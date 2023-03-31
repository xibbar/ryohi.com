require 'test_helper'

class DailyAllowanceTest < ActiveSupport::TestCase
  test 'company_id presence' do
    daily_allowance = create(:daily_allowance)
    daily_allowance.company_id = nil
    assert daily_allowance.invalid?
    assert_includes daily_allowance.errors[:company], I18n.t('errors.messages.blank')
  end

  test 'attributes presence' do
    daily_allowance = create(:daily_allowance)
    daily_allowance.name = nil
    assert daily_allowance.invalid?
    assert_includes daily_allowance.errors[:name], I18n.t('errors.messages.blank')

    daily_allowance = create(:daily_allowance)
    daily_allowance.one_day_allowance = nil
    assert daily_allowance.invalid?
    assert_includes daily_allowance.errors[:one_day_allowance], I18n.t('errors.messages.blank')

    daily_allowance = create(:daily_allowance)
    daily_allowance.accommodation_day_allowance = nil
    assert daily_allowance.invalid?
    assert_includes daily_allowance.errors[:accommodation_day_allowance], I18n.t('errors.messages.blank')

    daily_allowance = create(:daily_allowance)
    daily_allowance.return_day_allowance = nil
    assert daily_allowance.invalid?
    assert_includes daily_allowance.errors[:return_day_allowance], I18n.t('errors.messages.blank')
  end
end
