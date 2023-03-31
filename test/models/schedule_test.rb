require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @company = @user.companies.create(attributes_for(:company))
    @daily_allowance = @company.daily_allowances.create(attributes_for(:daily_allowance))
    @employee = @company.employees.create(attributes_for(:employee))
    @accommodation_charge = @company.accommodation_charges.create(attributes_for(:accommodation_charge))
    #@schedule = create(:schedule, employee: @employee, daily_allowance: @daily_allowance)
  end

  test 'attributes presence' do
    schedule = create(:one_day_schedule, employee: @employee, daily_allowance: @daily_allowance)
    schedule.days = nil
    assert schedule.invalid?
    assert_includes schedule.errors[:days], I18n.t('errors.messages.blank')

    schedule = create(:one_day_schedule, employee: @employee, daily_allowance: @daily_allowance)
    schedule.destination = nil
    assert schedule.invalid?
    assert_includes schedule.errors[:destination], I18n.t('errors.messages.blank')

    schedule = create(:one_day_schedule, employee: @employee, daily_allowance: @daily_allowance)
    schedule.business = nil
    assert schedule.invalid?
    assert_includes schedule.errors[:business], I18n.t('errors.messages.blank')

    schedule = create(:one_day_schedule, employee: @employee, daily_allowance: @daily_allowance)
    schedule.date = nil
    assert schedule.invalid?
    assert_includes schedule.errors[:date], I18n.t('errors.messages.blank')

    schedule = create(:accommodation_schedule, employee: @employee, daily_allowance: @daily_allowance, accommodation_charge: @accommodation_charge)
    schedule.accommodation_charge_id = nil
    assert schedule.invalid?
    assert_includes schedule.errors[:accommodation_charge_id], I18n.t('errors.messages.blank')
  end

  test '日帰りの日当と宿泊費' do
    schedule = create(:one_day_schedule, employee: @employee, daily_allowance: @daily_allowance)
    assert_not_nil schedule.daily_allowance_id
    assert schedule.daily_allowance_amount >= 0
    assert_equal schedule.daily_allowance_amount, schedule.daily_allowance.one_day_allowance
    assert_nil schedule.accommodation_charge_id
    assert_equal schedule.accommodation_charge_amount, 0
  end

  test '宿泊する日当と宿泊費' do
    schedule = create(:accommodation_schedule, employee: @employee, daily_allowance: @daily_allowance, accommodation_charge: @accommodation_charge)
    assert_not_nil schedule.daily_allowance_id
    assert_not_nil schedule.accommodation_charge_id
    assert schedule.daily_allowance_amount >= 0
    assert_equal schedule.daily_allowance_amount, schedule.daily_allowance.accommodation_day_allowance * (schedule.days - 1) + schedule.daily_allowance.return_day_allowance
    assert schedule.accommodation_charge_amount >= 0
    assert_equal schedule.accommodation_charge_amount, schedule.accommodation_charge.amount * (schedule.days - 1)
  end

  test 'method total' do
    schedule = create(:accommodation_schedule, employee: @employee, daily_allowance: @daily_allowance, accommodation_charge: @accommodation_charge)
    trip_expense = create(:trip_expense, schedule: schedule)
    assert_equal schedule.total, schedule.daily_allowance_amount + schedule.accommodation_charge_amount + schedule.trip_expenses.sum(:price)
  end

  test 'method accommocation_charge_id_required?' do
    schedule = create(:accommodation_schedule, employee: @employee, daily_allowance: @daily_allowance, accommodation_charge: @accommodation_charge)
    assert schedule.accommodation_charge_id_required?

    schedule.days = 1
    assert_not schedule.accommodation_charge_id_required?
  end

=begin
  test "日帰り日当なしの場合1日" do
    #employee = create(:employee, daily_allowance: 1500, accommodation_charges: 5000 )
    #schedule = create(:schedule, employee: employee, days: 1)
    @daily_allowance.update(one_day_allowance: 0, accommoation_day_allowance: 0, return_day_allowance: 0)
    schedule = create(:schedule, employee: @employee, daily_allowance: @daily_allowance)
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
=end
end
