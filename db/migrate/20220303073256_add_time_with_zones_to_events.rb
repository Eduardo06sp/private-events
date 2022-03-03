class AddTimeWithZonesToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :start_timewithzone, :string
    add_column :events, :end_timewithzone, :string
  end
end
