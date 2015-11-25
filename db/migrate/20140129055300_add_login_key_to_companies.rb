class AddLoginKeyToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :login_key, :string
  end
end
