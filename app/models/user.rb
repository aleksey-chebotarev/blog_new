class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  before_validation :nickname_downcase

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 39 }

  private

  def nickname_downcase
    self.nickname = nickname.downcase if nickname.present?
  end
end
