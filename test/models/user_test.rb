require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test 'ユーザーの作成' do
    user =  create(:user, login: 'xibbar')
    assert {user.login == "xibbar"}
  end

  test 'login presence' do
    @user.login = nil
    assert @user.invalid?
    assert_includes @user.errors[:login], I18n.t('errors.messages.blank')
  end

  test 'name presence' do
    @user.name = nil
    assert @user.invalid?
    assert_includes @user.errors[:name], I18n.t('errors.messages.blank')
  end

  test 'email presence' do
    @user.email = nil
    assert @user.invalid?
    assert_includes @user.errors[:email], I18n.t('errors.messages.blank')
  end

  test 'login should unique' do
    user2 = create(:user)
    user2.login = @user.login
    assert user2.invalid?
    assert_includes user2.errors[:login], I18n.t('errors.messages.taken')
  end

  test 'login should keep to format' do
    @user.login = 'user_01'
    assert @user.invalid?
    assert_includes @user.errors[:login], I18n.t('errors.messages.invalid')
  end

  test 'login length is too short' do
    @user.login = 'use'
    assert @user.invalid?
    assert_includes @user.errors[:login], I18n.t('errors.messages.too_short', count: 4)
  end

  test 'login length is too long' do
    @user.login = 'user123456789123456789123456789123456789123456789'
    assert @user.invalid?
    assert_includes @user.errors[:login], I18n.t('errors.messages.too_long', count: 40)
  end

  test 'email should unique' do
    user2 = create(:user)
    user2.email = @user.email
    assert user2.invalid?
    assert_includes user2.errors[:email], I18n.t('errors.messages.taken')
  end

  test 'password presence' do
    @user.password = ""
    assert @user.invalid?
    assert_includes @user.errors[:password], I18n.t('errors.messages.blank')
    assert_includes @user.errors[:password], I18n.t('errors.messages.too_short', count: 8)
  end

  test 'password should alphabet number' do
    @user.password = 'パスワード'
    assert @user.invalid?
    assert_includes @user.errors[:password], I18n.t('errors.messages.invalid_alnum')
  end

  test 'password not include number' do
    @user.password = 'password'
    assert @user.invalid?
    assert_includes @user.errors[:password], I18n.t('errors.messages.invalid_charactors')
  end

  test 'password not include alphabet' do
    @user.password = '123456789'
    assert @user.invalid?
    assert_includes @user.errors[:password], I18n.t('errors.messages.invalid_charactors')
  end

  test 'password should confirmation' do
    @user.password_confirmation = 'pass1234'
    assert @user.invalid?
    assert_includes @user.errors[:password_confirmation], I18n.t('errors.messages.confirmation')
  end

  test 'staff_restrict presence' do
    @user.staff_restrict = nil
    assert @user.invalid?
    assert_includes @user.errors[:staff_restrict], I18n.t('errors.messages.blank')
  end

  test 'staff_restrict should numericality' do
    @user.staff_restrict = 'five'
    assert @user.invalid?
    assert_includes @user.errors[:staff_restrict], I18n.t('errors.messages.not_a_number')
  end

  test 'prefecture presence' do
    @user.prefecture = nil
    assert @user.invalid?
    assert_includes @user.errors[:prefecture], I18n.t('errors.messages.blank')
  end

  test 'not keep to format email' do
    @user.email = 'test<@example.com'
    assert @user.invalid?
    assert_includes @user.errors[:email], I18n.t('errors.messages.invalid_email')

    @user.email = 'test@exampl%e.com'
    assert @user.invalid?
    assert_includes @user.errors[:email], I18n.t('errors.messages.invalid_email')

    @user.email = 'test@example.c'
    assert @user.invalid?
    assert_includes @user.errors[:email], I18n.t('errors.messages.invalid_email')
  end

  test 'current_password should valid when email update' do
    @user.current_password = 'pass'
    assert @user.invalid?(:email)
    assert_includes @user.errors[:current_password], I18n.t('errors.messages.mistake')
  end
end
