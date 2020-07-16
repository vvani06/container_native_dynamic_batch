class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.references :schedule, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
