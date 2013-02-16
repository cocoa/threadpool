# rspec

require 'rspec'
require 'threadpool'


RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end