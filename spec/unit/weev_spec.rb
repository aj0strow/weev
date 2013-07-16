require 'spec_helper'

describe Weev do
  after :each do
    Weev.send(:reset_settings!)
  end
  
  it 'should have a version' do
    expect(Weev::VERSION).not_to be_nil
  end
  
  it 'should have internal settings' do
    expect(Weev.send(:settings)).not_to be_nil
  end
  
  describe '::configure' do     
    specify 'setting options should change them' do
      Weev.configure do |config|
        config.camel_case = false
      end
      expect(Weev.send(:settings).camel_case).to be_false
    end
    
    specify 'camel case defaults to true' do
      expect(Weev.send(:settings).camel_case).to be_true
    end
  end
  
  describe '::camelize' do
    before :all do
      @method_name = 'hello_world'
    end
    
    it 'should camelcase a method name' do
      expect(Weev.camelize(@method_name)).to eq('helloWorld')
    end
    
    it 'should not camelize if setting is off' do
      Weev.configure do |config|
        config.camel_case = false
      end
      expect(Weev.camelize(@method_name)).to eq('hello_world')
    end
  end
end