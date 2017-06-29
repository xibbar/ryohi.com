class RemoveUnnecessaryColumn < ActiveRecord::Migration
  def change
    remove_column :employees, :daily_allowance
    remove_column :employees, :accommodation_charges
    remove_column :companies, :daily_allowance
    remove_column :schedules, :trip_expense_only
  end
end
