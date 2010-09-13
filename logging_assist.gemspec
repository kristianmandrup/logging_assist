# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{logging_assist}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2010-09-13}
  s.description = %q{Wraps logging in a nice and convenient way making it easy to apply on any project}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     ".rspec",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "lib/logging_assist.rb",
     "lib/logging_assist/logging.rb",
     "lib/logging_assist/namespaces.rb",
     "logging_assist.gemspec",
     "spec/logging_assist/logging_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/generator_assist}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Assists you in adding logging to any class such as a Generator}
  s.test_files = [
    "spec/logging_assist/logging_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.0.0.beta.19"])
      s.add_runtime_dependency(%q<require_all>, ["~> 1.1.0"])
      s.add_runtime_dependency(%q<sugar-high>, ["~> 0.2.3"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.0.0.beta.19"])
      s.add_dependency(%q<require_all>, ["~> 1.1.0"])
      s.add_dependency(%q<sugar-high>, ["~> 0.2.3"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.0.0.beta.19"])
    s.add_dependency(%q<require_all>, ["~> 1.1.0"])
    s.add_dependency(%q<sugar-high>, ["~> 0.2.3"])
  end
end

