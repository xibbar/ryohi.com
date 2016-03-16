require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'ユーザーの作成' do
    user =  create(:user, login: 'xibbar')
    assert {user.login == "xibbar"}
  end
end
