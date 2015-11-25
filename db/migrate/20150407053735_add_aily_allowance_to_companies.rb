class AddAilyAllowanceToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :aily_allowance, :boolean, default: false, null: false
  end
end
