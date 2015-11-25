class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer  :company_id
      t.string   :name
      t.integer  :aily_allowance
      t.integer  :accommodation_charges
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
