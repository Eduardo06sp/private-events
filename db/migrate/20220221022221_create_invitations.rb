class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.references :attendee, null: false, foreign_key: true
      t.references :attended_events, null: false, foreign_key: true

      t.timestamps
    end
  end
end
