require 'spec_helper'

class Abra
  def log
    @log ||= Rails::Assist::Logging.new 
  end  
end

describe 'BasicGenerator' do  
  before do              
    @abra = Abra.new
  end
    
  it "should log to logfile" do    
    @abra.log.debug 'debugged msg'
    @abra.log.info  'info msg here'    
  end
end