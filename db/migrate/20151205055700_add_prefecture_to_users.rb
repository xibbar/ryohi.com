class AddPrefectureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :prefecture, :string
  end
end
