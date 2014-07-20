module Barb
  class Receiver
    extend App
    extend DSL

    def intialize
    end

    def call(env)
      @env = env
      @request = Rack::Request.new(env)
      @env['payload'] =
        case @request.content_type
        when 'application/json'
          JSON.parse(Rack::Request.new(env).body.read)
        else
          nil
        end

      process if respond_to?(:process)
      empty_response
    end

    def payload
      @env['payload']
    end

    def request
      @request
    end

    private
    def empty_response
      [204, {}, ""]
    end
  end
end
