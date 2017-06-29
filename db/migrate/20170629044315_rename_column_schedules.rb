class RenameColumnSchedules < ActiveRecord::Migration
  def change
    rename_column :schedules, :accommodation_charges, :accommodation_charge_amount
    rename_column :schedules, :daily_allowance, :daily_allowance_amount
  end
end
