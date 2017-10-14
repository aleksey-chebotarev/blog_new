require 'rails_helper'

describe Api::V1::Author::PostsController, type: :request do
  let(:user)  { create :user, email: 'blog@email.example' }
  let!(:token) { { 'X-Auth-Token': auth_token(user.id) } }

  describe 'POST #create' do

    before { post '/api/v1/posts', params: params, headers: json_request_headers.merge!(token) }

    context 'when success' do
      context 'with published_at' do
        let(:published_at) { '10.10.2016' }
        let(:params) { { title: 'Title', body: 'Body', published_at: published_at }.to_json }

        specify do
          expect(response.body).to eq({
                                         id: Post.last.id,
                                         title: 'Title',
                                         body: 'Body',
                                         published_at: Time.parse(published_at),
                                         author_nickname: user.nickname
                                      }.to_json)
          expect(response).to have_http_status(201)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'when published_at is nil' do
        let(:params) { { title: 'Title', body: 'Body', published_at: '' }.to_json }

        specify do
          expect(json['published_at'].to_time.change(usec: 0)).to eq(Time.parse(Time.now.to_s))
          expect(response).to have_http_status(201)
          expect(response.content_type).to eq('application/json')
        end
      end
    end

    context 'when failure' do
      let(:params) { { title: '', body: '', published_at: '' }.to_json }

      specify do
        expect(response.body).to eq({
                                       errors: ['Body can\'t be blank', 'Title can\'t be blank']
                                    }.to_json)
        expect(response).to have_http_status(406)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end

