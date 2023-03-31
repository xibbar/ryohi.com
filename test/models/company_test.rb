require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "作成" do
    user = create(:user)
    rabbix = create(:company, user: user, name: 'ラビックス')
    assert {rabbix.name == "ラビックス"}
    prompt = create(:company, user: user, name: 'プロンプト')
    assert {prompt.name = "プロンプト"}
  end

  test 'should associate user' do
    company = create(:company)
    company.user_id = nil
    assert company.invalid?
    assert_includes company.errors[:user], I18n.t('errors.messages.blank')
  end

  test 'name presence' do
    company = create(:company)
    company.name = nil
    assert company.invalid?
    assert_includes company.errors[:name], I18n.t('errors.messages.blank')
  end
end

