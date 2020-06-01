class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :name
      t.time :run_at
      t.integer :calc_index

      t.timestamps
    end
  end
end
