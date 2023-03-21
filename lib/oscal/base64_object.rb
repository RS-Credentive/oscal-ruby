require_relative "serializer"

module Oscal
  class Base64Object
    include Serializer

    KEY = %i(filename media_type value)
    attr_accessor *KEY
    attr_serializable *KEY

    def self.wrap(obj)
      return obj if obj.is_a? Base64Object
      return Base64Object.new(obj) unless obj.is_a? Array

      obj.map do |x|
        Base64Object.wrap(x)
      end
    end

    def initialize(options={})
      options.each_pair.each do |key,val|
        key_name = key.gsub('-','_')

        unless KEY.include?(key_name.to_sym)
          raise UnknownAttributeError.new("Unknown key `#{key}` in Base64Object")
        end

        self.send("#{key_name}=", val)
      end
    end
  end
end