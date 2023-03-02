require 'test_helper'

class TripExpenseTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @company = create(:company, user: @user)
    @daily_allowance = create(:daily_allowance, company: @company)
    @employee = create(:employee, company: @company)
    @accommodation_charge = create(:accommodation_charge, company: @company)
    @schedule = create(:one_day_schedule, employee: @employee, daily_allowance: @daily_allowance)
    @trip_expense = create(:trip_expense, schedule: @schedule)
  end

  test 'attributes presence' do
    @trip_expense.schedule_id = nil
    assert @trip_expense.invalid?
    assert_includes @trip_expense.errors[:schedule_id], I18n.t('errors.messages.blank')

    @trip_expense.section = nil
    assert @trip_expense.invalid?
    assert_includes @trip_expense.errors[:section], I18n.t('errors.messages.blank')

    @trip_expense.way = nil
    assert @trip_expense.invalid?
    assert_includes @trip_expense.errors[:way], I18n.t('errors.messages.blank')

    @trip_expense.price = nil
    assert @trip_expense.invalid?
    assert_includes @trip_expense.errors[:price], I18n.t('errors.messages.blank')
  end

  test 'round must boolean' do
    @trip_expense.round = nil
    assert @trip_expense.invalid?
    assert_includes @trip_expense.errors[:round], I18n.t('errors.messages.inclusion')
  end

  test 'method date' do
    assert_equal @trip_expense.date, @schedule.date
  end

  test 'method section_view' do
    assert_equal @trip_expense.section + '（往復）', @trip_expense.section_view

    @trip_expense.round = false
    assert_equal @trip_expense.section, @trip_expense.section_view
  end

  test 'method add_template' do
    assert @trip_expense.add_template
  end
end
