class TestAttrsSerializer
  include Weev::Serializer
  
  strategy :default do
    attributes :a, :get_stuff
    attribute :method_name, 0, 1, 2
  end
end