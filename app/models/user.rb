class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable

  validates :email, uniqueness: true
  validates :username, uniqueness: true
end
