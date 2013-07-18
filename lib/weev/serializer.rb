module Weev
  module Serializer
    attr_reader :attrs, :relationships
    
    def initialize(name = nil)
      @attrs = {}
      @relationships = {}
      strategy(name) if name
    end
    
    def attributes(*method_names)
      method_names.each do |method_name|
        attribute(method_name)
      end
    end
    
    def attribute(method_name, *args)
      key = Weev.camelize(method_name)
      method_info = args.any? ? [method_name, *args] : method_name
      attrs[key] = method_info
    end
    
    def serialize(object)
      if Weev.collection?(object)
        serialize_all(object)
      else
        serialize_one(object)
      end
    end
    
    def relation(method_name, *params)
      relationships[method_name] = params
    end
    
    def strategy(name)
      method_name = Weev.namespace(name)
      if respond_to?(method_name)
        send method_name
      else
        raise "No strategy for #{self.class} named \"#{name}\"!"
      end
    end

    module ClassMethods
      def strategy(name, &block)
        define_method(Weev.namespace(name), &block)
      end
    end
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    private
    
    def serialize_all(objects)
      json = []
      objects.each do |object|
        json << serialize(object)
      end
      json
    end
    
    def serialize_one(object)
      json = {}
      attrs.each do |key, method_info|
        json[key] = object.send(*method_info)
      end
      relationships.each do |method_name, ary|
        *params, serializer = *ary
        key = Weev.camelize(method_name)
        rel = object.send(method_name, *params)
        json[key] = serializer.serialize(rel)
      end
      json
    end
  end
end