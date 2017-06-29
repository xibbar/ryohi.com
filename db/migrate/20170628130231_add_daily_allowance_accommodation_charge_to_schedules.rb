class AddDailyAllowanceAccommodationChargeToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :daily_allowance_id, :integer
    add_column :schedules, :accommodation_charge_id, :integer
  end
end
