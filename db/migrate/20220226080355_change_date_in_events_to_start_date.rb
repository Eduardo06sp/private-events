class ChangeDateInEventsToStartDate < ActiveRecord::Migration[6.1]
  change_table :events do |t|
    t.rename :date, :start_date
  end
end
