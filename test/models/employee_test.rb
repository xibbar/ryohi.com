require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @company = create(:company, user: @user)
    @employee = create(:employee, company: @company)
  end

  test 'company required' do
    @employee.company_id = nil
    assert @employee.invalid?
    assert_includes @employee.errors[:company], I18n.t('errors.messages.blank')
  end

  test 'name presence' do
    @employee.name = nil
    assert @employee.invalid?
    assert_includes @employee.errors[:name], I18n.t('errors.messages.blank')
  end

  test 'method monthly_total' do
    create(:one_day_schedule, employee: @employee)
    s_date = @employee.schedules.first.date
    assert @employee.monthly_total(s_date.year, s_date.month) >= 0
  end
end
