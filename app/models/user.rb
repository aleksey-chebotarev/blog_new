class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  before_validation :nickname_downcase

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 39 }
  validates :avatar, file_size: { less_than: 3.megabytes }

  private

  def nickname_downcase
    self.nickname = nickname.downcase if nickname.present?
  end
end
