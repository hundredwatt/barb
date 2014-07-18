require 'helper'

describe Barb::Receiver do
  subject { Class.new(Barb::Receiver) }

  def app
    subject
  end

  it "responds 204 with an empty body" do
    get '/'

    expect(last_response.status).to eq 204
    expect(last_response.body).to eq ""
  end
end
