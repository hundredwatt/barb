module Barb
  module Config
    def basic_auth(&blk)
      use Rack::Auth::Basic, &blk
    end

    def logger(logger = nil)
      if logger
        @logger = logger
      else
        @logger ||= Logger.new($stdout)
      end
    end

    # delegate to App module's #builder method
    def use(*)
      super
    end
  end
end
