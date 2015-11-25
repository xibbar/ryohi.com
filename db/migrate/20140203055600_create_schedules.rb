class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer  :target_month_id
      t.integer  :trip_date
      t.integer  :days
      t.string   :destination
      t.string   :business
      t.integer  :aily_allowance
      t.integer  :accommodation_charges

      t.timestamps
    end
  end
end
