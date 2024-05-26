# typed: true

require_relative "parsing_functions"
require_relative "logger"
require_relative "oscal_object"

module Oscal
  class Assembly
    include Oscal::ParsingFunctions
    include Oscal::ParsingLogger

    # This Idiocy is to support ruby's busted type system.
    class << self
      def mandatory_tags
        {}
      end

      def optional_tags
        {}
      end
    end

    def mandatory_attributes
      self.class.mandatory_tags.keys
    end

    def allowed_attributes
      mandatory_attributes + self.class.optional_tags.keys
    end

    def get_type_of_attribute(attribute_name)
      child_class = @tag_classes[attribute_name.to_sym]
      if child_class == nil
        raise InvalidTypeError, "No type found for #{attribute_name}"
      else
        child_class
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

    # def create_tag_class_hash(input)
    #   input.each_key do |tag|
    #     @tag_classes[tag] = input[tag]
    #   end
    # end

    # def get_mandatory_optional_tags
    #   # Create a local copy of the tag_classes class
    #   if self.class.constants.include?(:MANDATORY)
    #     create_tag_class_hash(MANDATORY)
    #   end

    #   if self.class.constants.include?(:OPTIONAL)
    #     create_tag_class_hash(OPTIONAL)
    #   end
    # end

    def missing_values?(provided)
      @logger.debug("Checking mandatory values: #{mandatory_attributes}")
      missing_values = mandatory_attributes -
        provided.keys.intersection(mandatory_attributes)
      if missing_values.length.positive?
        raise Oscal::InvalidTypeError,
              "Missing mandatory values: #{missing_values}"
      end
    end

    def extra_values?(provided)
      @logger.debug("Checking allowed values: #{allowed_attributes}")
      extra_values = provided.keys -
        provided.keys.intersection(allowed_attributes)
      if extra_values.length.positive?
        raise Oscal::InvalidTypeError,
              "Extra attributes provided #{extra_values}"
      end
    end

    def validate_input(input)
      @logger.debug("Checking mandatory and optional values.")
      missing_values?(input)
      extra_values?(input)
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
