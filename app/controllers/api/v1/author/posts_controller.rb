class Api::V1::Author::PostsController < Api::V1::Author::BaseController
  def show
    post = current_user.posts.find_by(id: params[:post_id])

    if post.present?
      render json: post, status: 200
    else
      render_error 'Post not found', 406
    end
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
      render json: post, status: 201
    else
      render json: { errors: post.errors.full_messages }, status: 406
    end
  end

  private

  def post_params
    params.permit(:title, :body, :published_at)
  end
end
