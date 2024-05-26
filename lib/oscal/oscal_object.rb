module Oscal
  class OscalObject
    MANDATORY = {}.freeze
    OPTIONAL = {}.freeze
    @@attribute_handlers = {}

    def mandatory_attributes
      if self.class.constants.include?(:MANDATORY)
        self.class::MANDATORY.keys
      else
        []
      end
    end

    def allowed_attributes
      if self.class.constants.include?(:OPTIONAL)
        mandatory_attributes + self.class::OPTIONAL.keys
      else
        mandatory_attributes
      end
    end

    def register_attribute_handler
      @@attribute_handler[self::ATTRIBUTE_ID] = self.class
    end

    def self_parse
      # Create a local copy of the tag_classes class
      if self.class.constants.include?(:MANDATORY)
        create_tag_class_hash(MANDATORY)
      end

      if self.class.constants.include?(:OPTIONAL)
        create_tag_class_hash(OPTIONAL)
      end
    end

    def check_and_normalize_input(input)
      @logger.debug("Checking to see if input is a Hash")
      unless input.is_a? Hash
        raise Oscal::InvalidTypeError,
              "Assemblies can only be created from Hash types"
      end
      @logger.debug("Assembly is hash with keys #{input.keys}")

      @logger.debug("Attempting to transform strings to symbols.")
      # Transform the keys from Strings to Symbols
      input.transform_keys { |key| str2sym(key) }
    end

    def validate_input(input)
      @logger.debug("Checking mandatory and optional values.")
      missing_values?(mandatory_attributes, input)
      extra_values?(allowed_attributes, input)
    end

    def missing_values?(mandatory, provided)
      @logger.debug("Checking mandatory values: #{mandatory}")
      missing_values = mandatory - provided.keys.intersection(mandatory)
      if missing_values.length.positive?
        raise Oscal::InvalidTypeError,
              "Missing mandatory values: #{missing_values}"
      end
    end

    def extra_values?(allowed, provided)
      @logger.debug("Checking allowed values: #{allowed}")
      extra_values = provided.keys - provided.keys.intersection(allowed)
      if extra_values.length.positive?
        raise Oscal::InvalidTypeError,
              "Extra attributes provided #{extra_values}"
      end
    end

    def validate_content(key, value)
      @logger.info("Validating #{value}")
      expected_class = get_type_of_attribute(key)
      @logger.debug("Attempting to instiate #{key} as #{expected_class}")
      instantiated = expected_class.new(value)
    rescue Oscal::InvalidTypeError
      raise Oscal::InvalidTypeError,
            "Value #{value.to_s[0, 25]} not a valid #{key}"
    else
      instantiated # Return the valid class
    end

    def initialize(input)
      @logger = get_logger
      @logger.debug("#{self.class}.new called with #{input.to_s[0, 25]}")

      super

      self_parse

      # Raise Exception if input is not a hash
      sym_hash = check_and_normalize_input(input)

      # Make sure all required and no extra keys are provided
      validate_input(sym_hash)

      # Attempt to convert each value to it's registered type
      sym_hash.each do |key, value|
        sym_hash[key] = validate_content(key, value)
      end
    end
  end
end
