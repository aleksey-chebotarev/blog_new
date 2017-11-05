class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true

  ALLOWED_TYPES = %w(Post).freeze

  before_create :time_now_if_published_at_is_nil

  validates :body, presence: true

  validates :commentable_type, presence: true,
    inclusion: {
      in: ALLOWED_TYPES,
      message: "%{value} type is not included in the list"
    }

  private

  def time_now_if_published_at_is_nil
    return false if published_at.present?

    self.published_at = Time.now
  end
end
