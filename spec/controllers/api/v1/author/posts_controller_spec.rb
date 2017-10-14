require 'rails_helper'

describe Api::V1::Author::PostsController, type: :request do
  let(:user)  { create :user, email: 'blog@email.example' }
  let!(:token) { { 'X-Auth-Token': auth_token(user.id) } }
  let!(:published_at) { '10.10.2016' }

  describe 'GET #show' do
    let(:post) { create :post, author: user, published_at: '10.10.2016' }
    let(:params) { { post_id: post.id } }

    context 'when success' do
      before { get "/api/v1/posts/#{post.id}", headers: json_request_headers.merge!(token) }

      specify do
        expect(response.body).to eq({
                                       id: post.id,
                                       title: post.title,
                                       body: post.body,
                                       published_at: Time.parse(published_at),
                                       author_nickname: user.nickname
                                    }.to_json)

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      before { get '/api/v1/posts/not_id', headers: json_request_headers.merge!(token) }

      specify do
        expect(response.body).to eq({
                                       error: { message: 'Post not found' }
                                    }.to_json)

        expect(response).to have_http_status(406)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'POST #create' do

    before { post '/api/v1/posts', params: params, headers: json_request_headers.merge!(token) }

    context 'when success' do
      context 'with published_at' do
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

  describe 'GET #index' do
    let!(:post) { create :post, author: user, published_at: published_at }

    before { get '/api/v1/posts', params: params, headers: json_request_headers.merge!(token) }

    context 'when success' do
      let(:params) { { page: 1, per_page: 2 } }

      specify do
        expect(response.body).to eq([
                                       {
                                          total_pages: params[:page],
                                          posts_count: Post.all.size
                                       },
                                       {
                                          id: Post.first.id,
                                          title: Post.first.title,
                                          body: Post.first.body,
                                          published_at: Time.parse(published_at),
                                          author_nickname: user.nickname
                                       }
                                    ].to_json)

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      let(:params) { { page: 1, per_page: '' } }

      specify do
        expect(response.body).to eq({
                                       error: { message: 'Incorrect parameters' }
                                    }.to_json)

        expect(response).to have_http_status(406)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end

