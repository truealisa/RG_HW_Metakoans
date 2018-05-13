def attribute(attr_arg, &block)
  @attributes = {}
  if attr_arg.is_a?(Hash)
    @attributes[attr_arg.keys[0]] = attr_arg.values[0]
  else
    @attributes[attr_arg] = nil
  end

  @attributes.each do |attribute, value|
    define_method "#{attribute}=" do |attr|
      instance_variable_set("@#{attribute}", attr)
    end

    define_method attribute.to_s do
      unless instance_variable_defined?("@#{attribute}")
        if block_given?
          instance_variable_set("@#{attribute}", instance_eval(&block))
        end
        instance_variable_set("@#{attribute}", value) if value
      end
      instance_variable_get("@#{attribute}")
    end

    define_method "#{attribute}?" do
      instance_variable_get("@#{attribute}").nil? ? false : true
    end
  end
end
