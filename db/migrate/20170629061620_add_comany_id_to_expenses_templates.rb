class AddComanyIdToExpensesTemplates < ActiveRecord::Migration
  def up
    add_column :expense_templates, :company_id, :integer
    ExpenseTemplate.all.each do |expense_template|
      employee = Employee.find(expense_template.employee_id)
      expense_template.update_attributes!(company_id: employee.company_id, section: "#{expense_template.section}[#{employee.name}]")
    end
  end
  def down
    ExpenseTemplate.all.each do |expense_template|
      employee = Employee.find(expense_template.employee_id)
      expense_template.update_attributes!(section: expense_template.section.sub(/\[.+\]$/,''))
    end
    remove_column :expense_templates, :company_id
  end
end
