require 'rspec'
require 'rspec/autorun'
require 'logging_assist'

RSpec.configure do |config|  
  config.mock_with :mocha
end
