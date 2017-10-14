class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true

  before_create :time_now_if_published_at_is_nil

  validates :body, presence: true

  private

  def time_now_if_published_at_is_nil
    return false if published_at.present?

    self.published_at = Time.now
  end
end
