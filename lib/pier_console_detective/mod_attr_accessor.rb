# Inspired and simplified from ActiveSupport's defintion of mattr_accessor
# https://github.com/rails/rails/blob/5db5de534106a44070374810a99853f38843b1d2/activesupport/lib/active_support/core_ext/module/attribute_accessors.rb

module ConsoleDetective
  module ModAttrAccessor
    def mod_attr_accessor(attr_name, default_value)
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        @@#{attr_name} = nil unless defined? @@#{attr_name}

        def self.#{attr_name}
          @@#{attr_name}
        end

        def self.#{attr_name}=(obj)
          @@#{attr_name} = obj
        end
      EOS

      send("#{attr_name}=", default_value) unless default_value.nil?
    end
  end
end