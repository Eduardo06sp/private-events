class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable

  has_many :attended_events, through: :invitations
  has_many :created_events, foreign_key: :creator_id, class_name: 'Event',
           dependent: :destroy
  has_many :invitations, foreign_key: :attendee_id

  validates :email, uniqueness: true
  validates :username, uniqueness: true
end
