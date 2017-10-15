require 'rails_helper'

describe Api::V1::Author::CommentsController, type: :request do
  let(:user) { create :user, email: 'blog@email.example' }
  let!(:token) { { 'X-Auth-Token': auth_token(user.id) } }

  describe 'GET #show' do
    let(:published_at) { '10.10.2016' }
    let(:comment) { create :comment, author: user, published_at: published_at }
    let(:params) { { comment_id: comment.id } }

    context 'when success' do
      before { get "/api/v1/comments/#{comment.id}", headers: json_request_headers.merge!(token) }

      specify do
        expect(response.body).to eq({
                                       id: comment.id,
                                       body: comment.body,
                                       published_at: Time.parse(published_at),
                                       author_nickname: user.nickname
                                    }.to_json)

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      before { get '/api/v1/comments/not_id', headers: json_request_headers.merge!(token) }

      specify do
        expect(response.body).to eq({
                                        error: { message: 'Comment not found' }
                                    }.to_json)

        expect(response).to have_http_status(406)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'POST #create' do
    before { post '/api/v1/comments', params: params, headers: json_request_headers.merge!(token) }

    context 'when success' do
      let(:post_new) { create :post }
      let(:published_at) { '10.10.2016' }
      let(:params) { { comment: { body: 'Body', published_at: published_at }, post_id: post_new.id }.to_json }

      specify do
        expect(response.body).to eq({
                                       id: Comment.last.id,
                                       body: 'Body',
                                       published_at: Time.parse(published_at),
                                       author_nickname: Comment.last.author.nickname
                                    }.to_json)

        expect(response).to have_http_status(201)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      context 'when body is nil' do
        let(:post_new) { create :post }
        let(:params) { { comment: { body: '' }, post_id: post_new.id }.to_json }

        specify do
          expect(response.body).to eq({
                                         errors: ['Body can\'t be blank']
                                      }.to_json)
          expect(response).to have_http_status(406)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'when post_id is nil' do
        let(:params) { { comment: { body: 'Body' }, post_id: '' }.to_json }

        specify do
          expect(response.body).to eq({
                                         error: { message: 'Post not found' }
                                      }.to_json)
          expect(response).to have_http_status(406)
          expect(response.content_type).to eq('application/json')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when success' do
      let(:comment) { create :comment, author: user }

      before { delete "/api/v1/comments/#{comment.id}", headers: json_request_headers.merge!(token) }

      specify do
        expect(response.body).to eq({
                                       data: 'Comment was succesfully destroyed'
                                    }.to_json)
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      before { delete "/api/v1/comments/not_comment", headers: json_request_headers.merge!(token) }

      specify do
        expect(response.body).to eq({
                                       error: { message: 'Comment not found' }
                                    }.to_json)
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
