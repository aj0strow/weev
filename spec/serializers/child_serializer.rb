class ChildSerializer
  include Weev::Serializer
  
  strategy :default do
    attribute :age
  end

end