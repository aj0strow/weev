module Weev
  module Serializer
    attr_reader :attrs, :relationships
    
    def initialize(strategy = nil)
      @attrs = {}
      @relationships = {}
      send(strategy) if strategy && respond_to?(strategy)
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

  end
end