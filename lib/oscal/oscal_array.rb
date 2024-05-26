require_relative("datatypes")
require_relative("logger")

module Oscal
  class OscalArray
    include ParsingLogger
    def input_is_array?(input)
      @logger.debug("#{self.class} checking to see if input was an Array.")
      unless input.is_a? Array
        raise InvalidTypeError,
              "#{self.class} must be an Array. Received #{input.class}."
      end
    end

    def validate_member_type(input)
      @logger.debug("Transforming Array elements to the expected type: #{self.class::MEMBER_TYPE}")
      input.map do |item|
        self.class::MEMBER_TYPE.new(item)
      end
    end

    def initialize(input)
      @logger = get_logger
      @logger.debug("#{self.class}.new called with #{input.to_s[0, 25]}")
      input_is_array?(input)
      validate_member_type(input)
    end
  end

  # These classes define generic arrays of basic DataTypes,
  # They appear in several different places in the Oscal specs
  # and can be subclassed with a different name
  class StringDataTypeArray < OscalArray
    MEMBER_TYPE = StringDataType
  end

  class TokenDataTypeArray < OscalArray
    MEMBER_TYPE = TokenDataType
  end

  class UuidArray < OscalArray
    MEMBER_TYPE = UuidDataType
  end
end
