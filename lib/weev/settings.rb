module Weev
  class Settings
    attr_accessor :camel_case
    
    def initialize
      self.camel_case = true
    end
  end
  
  private
  
  def self.settings
    @settings ||= Settings.new
  end
  
  def self.reset_settings!
    @settings = Settings.new
  end
end