class ParentSerializer
  include Weev::Serializer
  
  strategy :basic do
    attribute :name
  end
  
  strategy :detailed do
    strategy :basic
    attributes :first_name, :last_name
    relation :children, ChildSerializer.new(:default)
  end
  
  strategy :conditioned do
    relation :children, { age: 0..100 }, ChildSerializer.new(:default)
  end

end