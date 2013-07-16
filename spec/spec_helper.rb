require 'rubygems'
require 'bundler/setup'
require 'weev'

%w(include attrs).each do |type|
  require_relative "serializers/test_#{type}_serializer"
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
  attr_accessor :first_name, :last_name
  
  def children
    @children ||= 3.times.map do
      child = Child.new(age: rand(2..14))
    end 
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end

class Child < OrmObject
  attr_accessor :age
end