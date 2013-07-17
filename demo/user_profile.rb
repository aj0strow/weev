require 'multi_json'
require 'weev'

User = Struct.new(:first_name, :last_name, :links, :created_at) do
  def name
    "#{first_name} #{last_name}"
  end
  
  def joined_on(format)
    created_at.strftime(format)
  end
end

Link = Struct.new(:url, :link_text)

class LinkSerializer
  include Weev::Serializer
  
  strategy :default do
    attributes :url, :link_text
  end
end

class UserSerializer
  include Weev::Serializer
  
  strategy :name do
    attributes :first_name, :last_name, :name
  end
  
  strategy :profile do
    strategy :name
    attribute :joined_on, '%Y-%b-%d'
    relation :links, LinkSerializer.new(:default)
  end
end

links = [
  Link.new('http://github.com/', 'Github'),
  Link.new('http://stackoverflow.com/', 'Stack Overflow')
]

user = User.new('AJ', 'Ostrow', links, Time.now)

puts UserSerializer.new(:name).serialize(user)
# { 
#   "firstName"=>"AJ", 
#   "lastName"=>"Ostrow", 
#  "name"=>"AJ Ostrow"
# }

puts UserSerializer.new(:profile).serialize(user)
# {
#   "firstName"=>"AJ", 
#   "lastName"=>"Ostrow", 
#   "name"=>"AJ Ostrow", 
#   "joinedOn"=>"2013-Jul-16", 
#   "links"=>[
#     {
#       "url"=>"http://github.com/", 
#       "linkText"=>"Github"
#     }, 
#     {
#       "url"=>"http://stackoverflow.com/", 
#       "linkText"=>"Stack Overflow"
#     }
#   ]
# }







