class CreateTargetMonths < ActiveRecord::Migration
  def change
    create_table :target_months do |t|
      t.integer  :company_id
      t.integer  :employee_id
      t.string   :employee_name
      t.integer  :year
      t.integer  :month

      t.timestamps
    end
  end
end
