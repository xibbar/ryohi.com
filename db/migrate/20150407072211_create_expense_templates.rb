class CreateExpenseTemplates < ActiveRecord::Migration
  def change
    create_table :expense_templates do |t|
      t.integer :employee_id
      t.integer :position
      t.string  :section
      t.boolean :round, null: false, default: true
      t.string  :way
      t.integer :price

      t.timestamps
    end
  end
end
