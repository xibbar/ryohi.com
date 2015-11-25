class FixUserDefault < ActiveRecord::Migration
  def change
    change_column :users, "staff_restrict", :integer, default: 5, null: false
  end
end
