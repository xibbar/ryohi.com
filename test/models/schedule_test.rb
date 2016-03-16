require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  test "日帰り日当なしの場合1日" do
    employee = create(:employee, daily_allowance: 1500, accommodation_charges: 5000 )
    schedule = create(:schedule, employee: employee, days: 1)
    assert {schedule.daily_allowance == 0}
    assert {schedule.accommodation_charges ==0}
  end
  test "日帰り日当なしの場合2日" do
    employee = create(:employee, daily_allowance: 1500, accommodation_charges: 5000 )
    schedule = create(:schedule, employee: employee, days: 2)
    assert {schedule.daily_allowance == 3000}
    assert {schedule.accommodation_charges == 5000}
  end

  test "日帰り日当ありの場合1日" do
    company = create(:company)
    company.update_attributes(daily_allowance: true)
    employee = create(:employee, company: company, daily_allowance: 1500, accommodation_charges: 5000 )
    schedule = create(:schedule, employee: employee, days: 1)
    assert {schedule.daily_allowance == 1500}
    assert {schedule.accommodation_charges == 0}
  end
  test "日帰り日当ありの場合2日" do
    company = create(:company)
    company.update_attributes(daily_allowance: true)
    employee = create(:employee, company: company, daily_allowance: 1500, accommodation_charges: 5000 )
    schedule = create(:schedule, employee: employee, days: 2)
    assert {schedule.daily_allowance == 3000}
    assert {schedule.accommodation_charges == 5000}
  end
  test "旅費の登録2日" do
    company = create(:company)
    company.update_attributes(daily_allowance: true)
    employee = create(:employee, company: company, daily_allowance: 1500, accommodation_charges: 5000 )
    schedule = create(:schedule, employee: employee, days: 2)
    trip_expense = create(:trip_expense, schedule: schedule)
    assert {schedule.daily_allowance == 3000}
    assert {schedule.accommodation_charges == 5000}
    assert {trip_expense.price == 8500}
    assert {schedule.total == 16500}
    assert {employee.expense_templates.count == 0}
    trip_expense.add_template
    assert {employee.expense_templates.count == 1}
  end
end
