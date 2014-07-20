module Barb
  module Config
    def basic_auth(&blk)
      use Rack::Auth::Basic, &blk
    end

    # delegate to App module's #builder method
    def use(*)
      super
    end
  end
end
