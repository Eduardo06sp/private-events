class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable

  has_many :created_events, foreign_key: :creator_id, class_name: 'Event',
           dependent: :destroy
  has_many :event_attendings, foreign_key: :attendee_id
  has_many :attended_events, through: :event_attendings

  has_many :invitations, foreign_key: :invitee_id
  has_many :invited_events, through: :invitations

  validates :email, uniqueness: true, presence: true, length: { minimum: 5 }
  validates :username, uniqueness: true, presence: true, length: { in: 3..20 }
end
