class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.references :invitee, null: false, foreign_key: { to_table: :users }
      t.references :invited_event, null: false, foreign_key: { to_table: :events }

      t.timestamps
    end
  end
end
