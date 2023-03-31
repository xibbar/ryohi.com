require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    user = build(:user)
    get :create, params: {user: {login: user.login, email: user.email, name: user.name, state: user.state, prefecture: user.prefecture, password: "password1234"}}
    assert_redirected_to root_path
    assert_equal I18n.t('notice.create', model_name: User.model_name.human), flash[:notice]
  end

  test "must fail to create user" do
    get :create, params: {user: {login: @user.login, email: nil, name: nil}}
    assert_template :new
    assert_equal I18n.t('alert.cant_save'), flash[:alert]
  end

  test "should get name edit" do
    login_user @user, signin_path
    get :edit, params: {id: @user.id}
    assert_response :success
  end

  test "should update user name" do
    login_user @user, signin_path
    patch :update, params: {id: @user.id, user: {name: @user.name, current_password: "password1234"}}
    assert_redirected_to users_path
    assert_equal I18n.t('notice.update', model_name: User.model_name.human), flash[:notice]
  end

  test "must fail to update user name" do
    login_user @user, signin_path
    patch :update, params: {id: @user.id, user: {name: "", current_password: "password1234"}}
    assert_template :edit
    assert_equal I18n.t('alert.cant_save'), flash[:alert]
  end

  test "should get email edit" do
    login_user @user, signin_path
    get :email, params: {id: @user.id}
    assert_response :success
  end

  test "should update user email" do
    login_user @user, signin_path
    patch :update_email, params: {id: @user.id, user: {email: @user.email, current_password: "password1234"}}
    assert_redirected_to users_path
    assert_equal I18n.t('notice.update', model_name: User.model_name.human), flash[:notice]
  end

  test "must fail to update user email" do
    login_user @user, signin_path
    patch :update_email, params: {id: @user.id, user: {email: "", current_password: "password1234"}}
    assert_template :email
    assert_equal I18n.t('alert.cant_save'), flash[:alert]
  end

  test "should get prefecture edit" do
    login_user @user, signin_path
    get :prefecture, params: {id: @user.id}
    assert_response :success
  end

  test "should update user prefecture" do
    login_user @user, signin_path
    patch :update_prefecture, params: {id: @user.id, user: {prefecture: @user.prefecture, current_password: "password1234"}}
    assert_redirected_to users_path
    assert_equal I18n.t('notice.update', model_name: User.model_name.human), flash[:notice]
  end

  test "must fail to update user prefecture" do
    login_user @user, signin_path
    patch :update_prefecture, params: {id: @user.id, user: {prefecture: nil, current_password: "password1234"}}
    assert_template :prefecture
    assert_equal I18n.t('alert.cant_save'), flash[:alert]
  end

  test "should get password edit" do
    login_user @user, signin_path
    get :password, params: {id: @user.id}
    assert_response :success
  end

  test "should update user password" do
    login_user @user, signin_path
    patch :update_password, params: {id: @user.id, user: {password: "password1234", password_confirmation: "password1234", current_password: "password1234"}}
    assert_redirected_to users_path
    assert_equal I18n.t('notice.update', model_name: User.model_name.human), flash[:notice]
  end

  test "must fail to update user password" do
    login_user @user, signin_path
    patch :update_password, params: {id: @user.id, user: {password: "password1234", password_confirmation: "pass1234", current_password: "password"}}
    assert_template :password
    assert_equal I18n.t('alert.cant_save'), flash[:alert]
    assert_includes @user.errors.full_messages, "#{User.human_attribute_name(:current_password)}#{I18n.t('errors.messages.mistake')}"
  end

  test "should activate user" do
    @user = create(:user)
    get :activation, params: {activation_token: @user.activation_token}
    assert_redirected_to users_path
    assert_equal I18n.t('notice.activation'), flash[:notice]
  end

  test "should not activate user" do
    @user = create(:user)
    get :activation, params: {activation_token: "wrongtoken1234"}
    assert_redirected_to root_path
    assert_equal I18n.t('alert.code_missing'), flash[:alert]
  end
end
