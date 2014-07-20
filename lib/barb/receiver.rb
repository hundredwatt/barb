module Barb
  class Receiver
    extend App
    extend Config

    attr_reader :request

    def intialize
    end

    def call(env)
      @env = env
      @request = Rack::Request.new(env)
      decode_payload

      process if respond_to?(:process)
      empty_response
    end

    def payload
      @env['payload']
    end

    private

    def decode_payload
      @env['payload'] =
        case @request.content_type
        when 'application/json'
          MultiJson.load(Rack::Request.new(@env).body.read)
        when 'application/xml', 'text/xml'
          MultiXml.parse(Rack::Request.new(@env).body.read)
        else
          nil
        end
    end

    def empty_response
      [204, {}, '']
    end
  end
end
