module Barb
  class Receiver
    extend DSL

    class << self
      attr_reader :instance

      LOCK = Mutex.new

      def compile
        @instance ||= new
      end

      def change!
        @instance = nil
      end

      def call(env)
        LOCK.synchronize { compile } unless instance
        call!(env)
      end

      def call!(env)
        @app ||= begin
          builder.run instance
          builder.to_app
        end
        @app.call(env)
      end

      def use(*args, &blk)
        builder.use(*args, &blk)
      end

      def builder
        @builder ||= Rack::Builder.new
      end
    end

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

      process  if respond_to?(:process)
      empty_response
    end

    def payload
      @env['payload']
    end

    private
    def empty_response
      [204, {}, ""]
    end
  end
end
