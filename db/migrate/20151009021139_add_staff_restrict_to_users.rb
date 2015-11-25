class AddStaffRestrictToUsers < ActiveRecord::Migration
  def change
    add_column :users, :staff_restrict, :integer, null: false, default: 2
  end
end
