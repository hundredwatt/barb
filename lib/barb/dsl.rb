module Barb
  module DSL
    def basic_auth(&blk)
      use Rack::Auth::Basic, 'Barb', &blk
    end
  end
end