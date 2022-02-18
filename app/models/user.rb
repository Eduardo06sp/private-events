class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable

  has_many :created_events, foreign_key: :creator_id, class_name: 'Event',
           dependent: :destroy

  validates :email, uniqueness: true
  validates :username, uniqueness: true
end
