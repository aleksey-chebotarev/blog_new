class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  before_create :time_now_if_published_at_is_nil

  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 100 }

  private

  def time_now_if_published_at_is_nil
    return false if published_at.present?

    self.published_at = Time.now
  end
end
