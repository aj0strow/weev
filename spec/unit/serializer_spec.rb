require 'spec_helper'

describe Weev::Serializer do
  
  describe 'inclusion' do
    before :each do
      @serializer = TestIncludeSerializer.new
    end
    
    it 'should have a list of methods' do
      expect(@serializer.attrs).to eq({})
    end
    
    it 'should have a list of relations' do
      expect(@serializer.relationships).to eq({})
    end
  end
  
  describe 'methods' do
    before :each do
      @serializer = TestAttrsSerializer.new(:default)
    end
    
    it 'should add methods and args' do
      attrs = {
        'a' => :a,
        'getStuff' => :get_stuff,
        'methodName' => [:method_name, 0, 1, 2]
      }
      expect(@serializer.attrs).to eq(attrs)
    end
  end
  
end