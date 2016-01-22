class OnlyTripExpense < ActiveRecord::Migration
  def change
    add_column :schedules, :trip_expense_only, :boolean, default: false, null: false
  end
end
