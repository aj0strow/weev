require 'spec_helper'
require 'multi_json'

describe 'JSON Serialization' do
  before :all do
    @parent = Parent.new(first_name: 'Test', last_name: 'Object')
    @parent.children = 3.times.map do |i|
      Child.new(age: i)
    end
  end
  
  describe ParentSerializer do
    it 'should have a basic option' do
      @basic = ParentSerializer.new(:basic)
      expect(@basic.serialize(@parent)).to eq({ 'name' => 'Test Object' })
    end
    
    it 'should have a detailed option' do
      @detailed = ParentSerializer.new(:detailed)
      expected = {
        'name' => 'Test Object',
        'firstName' => 'Test',
        'lastName' => 'Object',
        'children' => [
          { 'age' => 0 },
          { 'age' => 1 },
          { 'age' => 2 }
        ]
      }
      expect(@detailed.serialize(@parent)).to eq(expected)
    end
    
    it 'should have a conditioned option' do
      @conditioned = ParentSerializer.new(:conditioned)
      expected = {
        'children' => [
          { 'age' => 0 },
          { 'age' => 1 },
          { 'age' => 2 }
        ]
      }
      expect(@conditioned.serialize(@parent)).to eq(expected)
    end
  
  end
  
end