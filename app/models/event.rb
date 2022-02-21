class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :attendees, through: :invitations, source: :attendee
end
