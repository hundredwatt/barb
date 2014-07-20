require 'helper'

describe Barb::Receiver do
  subject { Class.new(Barb::Receiver) }

  def app
    subject
  end

  it 'responds 204 with an empty body' do
    get '/'

    expect(last_response.status).to eq 204
    expect(last_response.body).to eq ''
  end

  it 'responds to POST requests' do
    post '/'

    expect(last_response.status).to eq 204
  end

  describe 'payload parsing' do
    describe 'json payload' do
      let(:content_type) { 'application/json' }
      let(:payload) { '{"key":"value"}' }

      it 'detects json and parses the payload' do
        post '/', payload, 'CONTENT_TYPE' => content_type

        expect(last_request.env['payload']).to eq('key' => 'value')
      end
    end

    describe 'json payload' do
      let(:content_type) { 'text/xml' }
      let(:payload) { '<tag id="1">name</tag>' }

      it 'detects json and parses the payload' do
        post '/', payload, 'CONTENT_TYPE' => content_type

        expect(last_request.env['payload']).to eq('tag' => {'id' => '1', '__content__' => 'name'})
      end
    end
  end

  describe '#process' do
    let(:content_type) { 'application/json' }
    let(:payload) { '{"key":"value"}' }

    RECEIVED_PAYLOADS = Queue.new

    subject do
      Class.new(Barb::Receiver) do
        def process
          RECEIVED_PAYLOADS << payload
        end
      end
    end

    it 'the #process callback is called with the payload accessible' do
      post '/', payload, 'CONTENT_TYPE' => content_type

      expect(RECEIVED_PAYLOADS.size).to eq 1
      expect(RECEIVED_PAYLOADS.pop).to eq('key' => 'value')
    end
  end
end
