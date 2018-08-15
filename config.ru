require "rack-timeout"
require 'rack'

use Rack::Timeout
use Rack::Lock # ensure requests are serial

app = Proc.new do |env|
  sleep Float(ENV["EXAMPLE_SLEEP_TIME"] || 0 )
  ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end

run app