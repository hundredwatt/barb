module Barb
  class Receiver
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
        instance.call(env)
      end
    end

    def intialize
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
