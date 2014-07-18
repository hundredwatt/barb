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

  it "responds to POST requests" do
    post '/'

    expect(last_response.status).to eq 204
  end

  describe "#payload" do
    describe "json payload" do
      let(:content_type) { 'application/json' }
      let(:payload) { '{"key":"value"}' }

      it "detects json and parses the payload" do
        post '/', payload, { 'CONTENT_TYPE' => content_type }

        expect(last_request.env['payload']).to eq({ "key" => "value" })
      end
    end
  end
end
