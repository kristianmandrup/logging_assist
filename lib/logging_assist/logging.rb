require 'active_support/inflector'
require 'log4r'
include Log4r

module Rails::Assist::BasicLogging
  def log
    @log ||= Rails::Assist::Logging.new 
  end  
end

module Rails::Assist
  class Logging    

    attr_reader :logger

    def logfile
      gen_logfile = RSpec::Generator.logfile if defined?(RSpec::Generator) 
      gen_logfile || @logfile || 'logging.log'
    end

    def logfile= file
      @logfile = file
    end

    # DEBUG < INFO < WARN < ERROR < FATAL
    DEBUG_LVS = [:debug, :info, :warn, :error, :fatal]

    def initialize options = {:level => :debug}
      Log4r::Logger.global.level = Log4r::ALL
      @logger ||= Log4r::Logger.new('logger')            
      add_stdout options[:level]
    end

    def add_outputter outputter
      logger.outputters << outputter
    end      

    def remove_outputter outputter
      logger.outputters.delete(outputter)
    end      

    def debug_lv= level
      raise ArgumentError, "Debug lv must be one of #{DEBUG_LVS}" if !DEBUG_LVS.include? lv
      logger.each_outputter do |name, outputter|
        outputter.level = get_lv(level)        
      end
    end      

    def add_stdout level = :debug
      add_outputter Log4r::StdoutOutputter.new 'console', :formatter => simple_formatter, :level => get_lv(level)
    end
    
    def add_logfile options = {:level => :debug}
      level = options[:level]
      add_outputter FileOutputter.new "logfile", :filename => options[:logfile] || logfile, :formatter => simple_formatter, :level => get_lv(level)
    end    

    def debug msg
      set_log_class do
        logger.debug "[#{@log_class}]"
      end
      logger.debug "#{msg}" 
    end

    def info msg
      set_log_class do
        logger.info "[#{@log_class}]"
      end
      logger.info "-- #{msg}" 
    end

    def warn msg
      set_log_class do
        logger.warn "[#{@log_class}]"
      end
      logger.warn draw_line
      logger.warn ":: #{msg}" 
    end

    def error msg
      set_log_class do
        logger.warn "[#{@log_class}]"
      end
      logger.error draw_line
      logger.error "! #{msg.upcase}" 
      logger.error      
    end

    def fatal msg
      set_log_class do
        logger.warn "[#{@log_class}]"
      end
      logger.fatal draw_line :char => '='
      logger.error "**** #{msg.upcase} ****" 
      logger.fatal draw_line :char => '='
    end

    protected

    def get_lv level = :debug
      raise ArgumentError, "Debug lv must be one of #{DEBUG_LVS}" if !DEBUG_LVS.include? level
      "Log4r::#{level.to_s.upcase}".constantize
    end      

    def simple_formatter
      PatternFormatter.new(:pattern => "%m")      
    end
    
    def set_log_class &block
      if self.class != @log_class
        @log_class = self.class 
        yield if block
      end
    end

    def draw_line options = {:size => 40, :char => '-'}
      options[:char] * options[:size]
    end             
  end
end