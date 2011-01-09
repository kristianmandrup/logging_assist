require 'spec_helper'

class Abra
  include Rails3::Assist::BasicLogger
end

def do_logging obj
  obj.logger.debug 'debugged msg'
  obj.logger.info  'info msg here'    
  obj.logger.warn  'warn msg here'    
  obj.logger.error  'error msg here'    
  obj.logger.fatal  'error msg here'
end  

describe 'BasicGenerator' do  
  before do              
    @abra = Abra.new
  end

  it "should log to stdout" do    
    do_logging @abra
  end

  it "should allow change of color for each level" do
    obj = @abra
    
    obj.logger.set_color :debug, {:color => :blue, :background => :white}
    obj.logger.info  'blue on white!'      

    obj.logger.set_color :info, {:color => :green, :background => :white}
    obj.logger.info  'green on white!'      

    obj.logger.info_color[:color].should == :green
    obj.logger.info_color[:background].should == :white
    
    obj.logger.set_color :warn, {:color => :black, :background => :white}
    obj.logger.warn  'black on white!'      
    
    obj.logger.warn_color[:color].should == :black
    obj.logger.warn_color[:background].should == :white    
  end
    
  it "should log to logfile" do    
    @abra.logger.add_logfile :logfile => 'here.log'    
    do_logging @abra
  end
end