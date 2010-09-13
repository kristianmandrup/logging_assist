begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "logging_assist"
    gem.summary = %Q{Assists you in adding logging to any class such as a Generator}
    gem.description = %Q{Wraps logging in a nice and convenient way making it easy to apply on any project}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/generator_assist"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency  "rspec",        "~> 2.0.0.beta.22"
    gem.add_dependency              "require_all",  "~> 1.1.0"    
    gem.add_dependency              "sugar-high",   "~> 0.2.5"
    gem.add_dependency              "log4r",        "~> 1.1.8"
        
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

