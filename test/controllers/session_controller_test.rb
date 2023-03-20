require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login as user" do
    @user.update(state: "active")
    post :create, params: {login: @user.login, password: "password1234"}
    assert_redirected_to schedules_path
    assert_equal I18n.t('notice.login_successfull'), flash[:notice]
  end

  test "should fail to login as user" do
    post :create, params: {login: @user.login, password: "pass"}
    assert_redirected_to root_path
    assert_equal I18n.t('alert.failer_login'), flash[:alert]
  end

  test "should logout" do
    login_user @user, signin_path
    get :destroy
    logout_user
    assert_redirected_to root_path
    assert_equal I18n.t('notice.logged_out'), flash[:notice]
  end

  test "should get download_ryohikitei" do
    login_user @user, signin_path
    get :download_ryohikitei
    assert_response :success
    assert_equal response.content_type, 'application/pdf'
  end
end
