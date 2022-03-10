class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :event_attendings, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :event_attendings, source: :attendee

  scope :upcoming, -> { where('events.start_timewithzone >= ?', Time.current) }
  scope :past, -> { where('events.end_timewithzone < ?', Time.current) }
end
