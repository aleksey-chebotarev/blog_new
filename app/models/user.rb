class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :nickname_downcase

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 39 }

  private

  def nickname_downcase
    self.nickname = nickname.downcase if nickname.present?
  end
end
