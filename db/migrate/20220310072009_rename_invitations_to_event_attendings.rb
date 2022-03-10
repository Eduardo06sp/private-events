class RenameInvitationsToEventAttendings < ActiveRecord::Migration[6.1]
  def change
    rename_table :invitations, :event_attendings
  end
end
