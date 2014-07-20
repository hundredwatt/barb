module Barb
  module App
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
end
