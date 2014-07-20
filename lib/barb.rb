require "barb/version"

require 'json'
require 'rack'
require 'rack/auth/basic'

module Barb
  autoload :Receiver, 'barb/receiver'
  autoload :App, 'barb/app'
  autoload :Config, 'barb/config'
end
