require 'spec_helper'

class Abra
  include Rails3::Assist::BasicLogger
end

describe 'BasicGenerator' do  
  before do              
    @abra = Abra.new
  end

  it "should log to stdout" do    
    @abra.logger.debug 'debugged msg'
    @abra.logger.info  'info msg here'    
  end
    
  it "should log to logfile" do    
    @abra.logger.add_logfile :logfile => 'here.log'    
    @abra.logger.debug 'debugged msg'
    @abra.logger.info  'info msg here'    
  end
end