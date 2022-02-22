class RenameInvitationAttendedEventsIdToAttendedEventId < ActiveRecord::Migration[6.1]
  def change
    rename_column :invitations, :attended_events_id, :attended_event_id
  end
end
