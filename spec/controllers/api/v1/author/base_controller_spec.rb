require 'rails_helper'

describe Api::V1::Author::BaseController, type: :request do
  let(:user) { create :user, email: 'blog@email.example' }

  before { post '/api/v1/posts', headers: json_request_headers.merge!(token) }

  describe 'Authenticate process' do
    let(:token) { { 'X-Auth-Token': '' } }

    it 'when auth token is nil' do
      expect(response.body).to eq({
                                     error: { message: 'Not Authenticated' }
                                  }.to_json)
    end
  end

  describe 'Authentication Timeout' do
    let(:expiration) { Time.now - 5.minutes }
    let(:token) { { 'X-Auth-Token': AuthToken.encode({ user_id: user.id }, expiration) } }

    it 'when the token has expired' do
      expect(response.body).to eq({
                                     error: { message: 'Authentication Timeout' }
                                  }.to_json)
    end
  end
end
