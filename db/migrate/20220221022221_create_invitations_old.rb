class CreateInvitationsOld < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.references :attendee, null: false, foreign_key: {to_table: :users}
      t.references :attended_events, null: false, foreign_key: {to_table: :events}

      t.timestamps
    end
  end
end
