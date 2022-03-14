class AddInvitedUsersToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :invited_users, :text, array: true, default: []
  end
end
