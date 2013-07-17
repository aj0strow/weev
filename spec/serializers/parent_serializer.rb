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

end