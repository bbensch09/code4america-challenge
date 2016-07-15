class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations do |t|
      t.integer :violation_id
      t.integer :inspection_id
      t.string :violation_category
      t.datetime :violation_date
      t.datetime :violation_date_closed
      t.string :violation_type

      t.timestamps null: false
    end
  end
end
