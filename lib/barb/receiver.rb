module Barb
  class Receiver
    class << self
      attr_reader :instance

      LOCK = Mutex.new

      def basic_auth(&blk)
        use Rack::Auth::Basic, 'Barb', &blk
      end

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
          builder = Rack::Builder.new

          [*@middleware].each do |m|
            m = m.dup
            block = m.pop if m.last.is_a?(Proc)
            if block
              builder.use(*m, &block)
            else
              builder.use(*m)
            end
          end
          builder.run instance
          builder.to_app
        end
        @app.call(env)
      end

      def use(middleware, *args, &blk)
        m = [middleware, *args]
        m << blk if block_given?
        @middleware ||= []
        @middleware << m
      end
    end

    def intialize
      @middleware ||= []
    end

    def call(env)
      empty_response
    end

    private
    def empty_response
      [204, {}, ""]
    end
  end
end
