require 'test_helper'

class AccommodationChargeTest < ActiveSupport::TestCase
  test 'company_id presence' do
    accommodation_charge = create(:accommodation_charge)
    accommodation_charge.company_id = nil
    assert accommodation_charge.invalid?
    assert_includes accommodation_charge.errors[:company], I18n.t('errors.messages.blank')
  end

  test 'name amount presence' do
    accommodation_charge = create(:accommodation_charge)
    accommodation_charge.name = nil
    assert accommodation_charge.invalid?
    assert_includes accommodation_charge.errors[:name], I18n.t('errors.messages.blank')

    accommodation_charge.name = 'sample'
    accommodation_charge.amount = nil
    assert accommodation_charge.invalid?
    assert_includes accommodation_charge.errors[:amount], I18n.t('errors.messages.blank')
  end
end
