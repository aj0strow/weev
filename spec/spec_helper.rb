require 'rubygems'
require 'bundler/setup'
require 'weev'

%w(test_include test_attrs parent child test_relations).each do |type|
  require_relative "serializers/#{type}_serializer"
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

class OrmObject
  def initialize(hash = {})
    hash.each do |attrib, value|
      send("#{attrib}=", value)
    end
  end
end

class Parent < OrmObject
  attr_accessor :first_name, :last_name, :children
  
  def name
    "#{first_name} #{last_name}"
  end
end

class Child < OrmObject
  attr_accessor :age
end
