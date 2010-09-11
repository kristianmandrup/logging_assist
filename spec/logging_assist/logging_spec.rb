require 'spec_helper'

class Abra
  include Rails::Assist::BasicLogging
end

describe 'BasicGenerator' do  
  before do              
    @abra = Abra.new
  end

  it "should log to stdout" do    
    @abra.log.debug 'debugged msg'
    @abra.log.info  'info msg here'    
  end
    
  it "should log to logfile" do    
    @abra.log.add_logfile    
    @abra.log.debug 'debugged msg'
    @abra.log.info  'info msg here'    
  end
end