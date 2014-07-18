require "barb/version"

require 'json'
require 'rack'
require 'rack/auth/basic'

module Barb
  autoload :Receiver, 'barb/receiver'
  autoload :DSL, 'barb/dsl'
end
