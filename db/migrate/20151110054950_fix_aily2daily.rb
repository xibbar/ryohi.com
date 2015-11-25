class FixAily2daily < ActiveRecord::Migration
  def change
    rename_column :companies, :aily_allowance, :daily_allowance
    rename_column :employees, :aily_allowance, :daily_allowance
    rename_column :schedules, :aily_allowance, :daily_allowance
  end
end
