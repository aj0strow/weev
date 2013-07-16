require 'weev/version'
require 'weev/settings'
require 'weev/serializer'

module Weev
  
  def self.configure
    yield settings
  end
  
  def self.camelize(method_name)
    key = method_name.to_s
    if settings.camel_case
      key.gsub(/\_([[:alpha:]])/){ $1.upcase }
    else
      key
    end
  end

end
