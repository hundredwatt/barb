require "barb/version"

require 'json'
require 'rack'
require 'rack/auth/basic'

module Barb
  autoload :Receiver, 'barb/receiver'
  autoload :App, 'barb/app'
  autoload :DSL, 'barb/dsl'
end
