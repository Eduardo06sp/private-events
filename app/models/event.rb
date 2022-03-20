class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :event_attendings, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :event_attendings, source: :attendee

  has_many :invitations, foreign_key: :invited_event_id, dependent: :destroy
  has_many :invitees, through: :invitations, source: :invitee

  scope :upcoming, -> { where('events.start_timewithzone >= ?', Time.current) }
  scope :past, -> { where('events.end_timewithzone < ?', Time.current) }

  validates :name, presence: true, length: { in: 3..50 }
  validates :location,
            :start_date,
            :start_time,
            :end_date,
            :end_time, presence: true
end
