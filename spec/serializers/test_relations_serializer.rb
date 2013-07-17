class TestRelationsSerializer
  include Weev::Serializer
  
  strategy :any_name do
    relation :relateds, RelatedSerializer.new(:nested)
  end
end

class RelatedSerializer
  include Weev::Serializer
  
  strategy :nested do
    attributes :cool, :cold
  end
end