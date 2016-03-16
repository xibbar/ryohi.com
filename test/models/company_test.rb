require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "作成" do
    user = create(:user)
    rabbix = create(:company, user: user, name: 'ラビックス')
    assert {rabbix.name == "ラビックス"}
    prompt = create(:company, user: user, name: 'プロンプト')
    assert {prompt.name = "プロンプト"}
  end
end

