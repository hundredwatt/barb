require 'helper'

describe Barb::DSL do
  describe "#basic_auth" do
    subject do
      Class.new(Barb::Receiver) do
        basic_auth do |u, p|
          u && p && u == p
        end
      end
    end

    def app
      subject
    end

    it 'throws a 401 if no auth is given' do
      get '/'

      expect(last_response.status).to eq(401)
    end

    it 'authenticates if given valid creds' do
      get '/', {}, 'HTTP_AUTHORIZATION' => encode_basic_auth('admin', 'admin')

      expect(last_response.status).to eq(204)
    end

    it 'throws a 401 is wrong auth is given' do
      get '/', {}, 'HTTP_AUTHORIZATION' => encode_basic_auth('admin', 'wrong')

      expect(last_response.status).to eq(401)
    end
  end

  def encode_basic_auth(username, password)
    'Basic ' + ["#{username}:#{password}"].pack("m*")
  end
end
