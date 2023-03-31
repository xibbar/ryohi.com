require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    login_user @user, signin_path
    @company = @user.companies.create(attributes_for(:company))
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company" do
    post :create, params: {company: {user_id: @user.id, name: @company.name}}
    assert_redirected_to companies_path
    assert_equal I18n.t('notice.create', model_name: Company.model_name.human), flash[:notice]
  end

  test "should fail to create company" do
    post :create, params: {company: {user_id: @user.id, name: nil}}
    assert_template :new
    assert_equal I18n.t('alert.cant_save'), flash[:alert]
  end

  test "should get edit" do
    get :edit, params: {id: @company}
    assert_response :success
  end

  test "should update company" do
    patch :update, params: {id: @company, company: {name: @company.name}}
    assert_redirected_to companies_path
    assert_equal I18n.t('notice.update', model_name: Company.model_name.human), flash[:notice]
  end

  test "should fail to update company" do
    patch :update, params: {id: @company, company: {name: nil}}
    assert_template :edit
    assert_equal I18n.t('alert.cant_save'), flash[:alert]
  end

  test "should destroy company" do
    assert_difference("Company.count", -1) do
      delete :destroy, params: {id: @company}
    end
    assert_redirected_to companies_path
    assert_equal I18n.t('notice.destroy', model_name: Company.model_name.human), flash[:notice]
  end
end
