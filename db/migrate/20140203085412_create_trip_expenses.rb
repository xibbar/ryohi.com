class CreateTripExpenses < ActiveRecord::Migration
  def change
    create_table :trip_expenses do |t|
      t.integer  :schedule_id
      t.string   :section
      t.boolean  :round,  null: false, default: true
      t.string   :way
      t.integer  :price

      t.timestamps
    end
  end
end
