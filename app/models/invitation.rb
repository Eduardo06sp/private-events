class Invitation < ApplicationRecord
  belongs_to :attendee
  belongs_to :attended_events
end
