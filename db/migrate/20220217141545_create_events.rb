class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :date
      t.string :start_time
      t.string :end_time
      t.text :description
      t.boolean :private

      t.timestamps
    end
  end
end
