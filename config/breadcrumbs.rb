crumb :root do
  link "トップ", root_path
end
crumb :schedules do
  link "出張の管理", schedules_path
end
crumb :schedule do |schedule|
  link "詳細", schedule_path(schedule)
  parent :schedules
end
crumb :new_schedule do
  link "新規", new_schedule_path
  parent :schedules
end
crumb :edit_schedule do |schedule|
  link "編集", edit_schedule_path(schedule)
  parent :schedule, schedule
end
crumb :monthly_reports do
  link "月別集計表", monthly_reports_path
end
crumb :monthly_report do |employee|
  link "詳細", monthly_report_path(employee)
  parent :monthly_reports
end
crumb :privacy_policy do
  link "プライバシーポリシー", privacy_policy_path
end
crumb :agreement do
  link "利用規約", agreement_path
end
crumb :operating_company do
  link "運営会社", operating_company_path
end
crumb :legal do
  link "特定商取引法に基づく表記", legal_path
end
crumb :companies do 
  link "企業の管理", companies_path
end
crumb :new_company do
  link "新規", new_company_path
  parent :companies
end
crumb :edit_company do |company|
  link "編集", edit_company_path(company)
  parent :companies
end
crumb :company_employees do |company|
  link "社員一覧（#{company.name}）", company_employees_path(company)
  parent :companies
end
crumb :company_employee_expense_templates do |company, employee|
  link employee.name, company_employee_expense_templates_path(company, employee)
  parent :company_employees, company
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
