class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :invitations, foreign_key: :attended_event_id
  has_many :attendees, through: :invitations, source: :attendee

  def self.upcoming
    Event.joins(:creator).where('events.start_timewithzone >= ?', Time.current)
  end

  def self.past
    Event.joins(:creator).where('events.end_timewithzone < ?', Time.current)
  end
end
