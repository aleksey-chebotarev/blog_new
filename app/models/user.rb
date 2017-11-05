class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  before_validation :nickname_downcase

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 39 }
  validates :avatar, file_size: { less_than: 3.megabytes }

  def self.build_report(start_date, end_date)
    start_date_sanitize = ActiveRecord::Base.connection.quote(start_date)
    end_date_sanitize = ActiveRecord::Base.connection.quote(end_date)

    joins("LEFT OUTER JOIN posts ON users.id = posts.author_id AND posts.published_at
      BETWEEN #{start_date_sanitize} AND #{end_date_sanitize}")
      .joins("LEFT OUTER JOIN comments ON users.id = comments.author_id AND comments.published_at
        BETWEEN #{start_date_sanitize} AND #{end_date_sanitize}")
      .select('users.id, users.email, users.nickname, COUNT(DISTINCT posts.id) AS posts_size,
        COUNT(DISTINCT comments.id) AS comments_size,
        COUNT(DISTINCT posts.id) + COUNT(DISTINCT comments.id) / 10 AS position_column')
      .having('COUNT(posts.id) > 0 OR COUNT(comments.id) > 0')
      .group('users.id')
      .order('position_column DESC')
  end

  private

  def nickname_downcase
    self.nickname = nickname.downcase if nickname.present?
  end
end
