require 'active_support/inflector'
require 'log4r-color'
require 'active_support'
include Log4r

module Rails3::Assist::BasicLogger
  def logger
    @logger ||= Rails3::Assist::Logging.new 
  end  
end

module Rails3::Assist
  class Logging    

    attr_reader :logger 
    
    attr_accessor :info_color, :debug_color, :warn_color, :error_color, :fatal_color      

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
      color_options = options[:color_options] if options
    end

    def add_outputter outputter
      logger.outputters << outputter
    end      

    def remove_outputter outputter
      logger.outputters.delete(outputter)
    end      

    def remove_outputs type
      klass = "Log4r::#{type.to_s.classify}Outputter".constantize
      logger.outputters.each do |outp|
        logger.outputters.delete(outp) if outp.kind_of? klass
      end
    end

    # def remove_all_file_outputs
    #   logger.outputters.each do |outp|
    #     logger.outputters.delete(outp) if outp.kind_of? Log4r::FileOutputter
    #   end
    # end

    def debug_lv= level
      raise ArgumentError, "Debug lv must be one of #{DEBUG_LVS}" if !DEBUG_LVS.include? lv
      logger.each_outputter do |name, outputter|
        outputter.level = get_lv(level)        
      end
    end      

    def add_stdout level = :debug
      add_outputter Log4r::ColorOutputter.new 'color', :formatter => simple_formatter, :level => get_lv(level), :colors => default_colors
    end

    def default_colors  
      DEBUG_LVS.inject({}) do |res, lv|
        res[lv] = send :"default_#{lv}_color"
        res
      end
    end

    def set_color name, color_options = {}
      send :"#{name}_color=", color_options
      Outputter['color'].colors[name.to_sym] = color_options
      Outputter['color'].colors
    end

    # def available_levels
    #   DEBUG_LVS # [:debug, :info, :warn, :error, :fatal]
    # end

    def default_debug_color
      :cyan
    end

    def default_info_color
      :light_blue
    end

    def default_warn_color
      :yellow
    end

    def default_error_color
      :red
    end

    def default_fatal_color
      {:color => :white, :background => :red}
    end

    
    def add_logfile options = {}
      add_outputter FileOutputter.new "logfile", :filename => options[:logfile] || logfile, :formatter => simple_formatter, :level => get_lv(options[:level] || :debug)
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
      raise ArgumentError, "Debug lv must be one of #{DEBUG_LVS}, was #{level}" if !DEBUG_LVS.include? level
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
      options[:char] * (options[:size] || 40)
    end             
  end
end