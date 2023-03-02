require 'test_helper'

class ExpenseTemplateTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @company = create(:company, user: @user)
  end

  test 'company_id presence' do
    expense_template = create(:expense_template, company: @company)
    expense_template.company_id = nil
    assert expense_template.invalid?
    assert_includes expense_template.errors[:company], I18n.t('errors.messages.blank')
  end

  test 'attributes presence' do
    expense_template = create(:expense_template, company: @company)
    expense_template.section = nil
    assert expense_template.invalid?
    assert_includes expense_template.errors[:section], I18n.t('errors.messages.blank')

    expense_template = create(:expense_template, company: @company)
    expense_template.way = nil
    assert expense_template.invalid?
    assert_includes expense_template.errors[:way], I18n.t('errors.messages.blank')

    expense_template = create(:expense_template, company: @company)
    expense_template.price = nil
    assert expense_template.invalid?
    assert_includes expense_template.errors[:price], I18n.t('errors.messages.blank')
  end

  test 'round must boolean' do
    expense_template = create(:expense_template, company: @company)
    expense_template.round = nil
    assert expense_template.invalid?
    assert_includes expense_template.errors[:round], I18n.t('errors.messages.inclusion')
  end

  test 'same content validate' do
    expense_template = create(:expense_template, company: @company)
    attributes = expense_template.attributes
    attributes.delete("id")
    attributes.delete("created_at")
    attributes.delete("updated_at")
    dup_et = @company.expense_templates.build(attributes)
    assert dup_et.invalid?
    assert_includes dup_et.errors[:section], I18n.t('errors.messages.taken')
  end

  test 'method test view' do
    expense_template = create(:expense_template, company: @company)
    expense_template.updated_at = Time.new(2019, 10, 2)
    assert_equal expense_template.view, "#{expense_template.section} #{expense_template.way} (#{I18n.t('round.' + expense_template.round.to_s)}) #{ ActionController::Base.helpers.number_to_currency expense_template.price }"

    expense_template.updated_at = Time.new(2019, 9, 30)
    assert_equal expense_template.view, "（！） #{expense_template.section} #{expense_template.way} (#{I18n.t('round.' + expense_template.round.to_s)}) #{ ActionController::Base.helpers.number_to_currency expense_template.price }"
  end

  test 'method test merge' do
    @daily_allowance = @company.daily_allowances.create(attributes_for(:daily_allowance))
    @employee = @company.employees.create(attributes_for(:employee))
    @accommodation_charge = @company.accommodation_charges.create(attributes_for(:accommodation_charge))
    @schedule = create(:one_day_schedule, employee: @employee, daily_allowance: @daily_allowance)
    trip_expense = create(:trip_expense, schedule: @schedule)
    expense_template = build(:expense_template, company: @company)
    assert expense_template.merge(trip_expense)


    trip_expense = create(:trip_expense, schedule: @schedule)
    expense_template = build(:expense_template, company: @company)
    trip_expense.price = nil
    assert_not expense_template.merge(trip_expense)
  end
end
