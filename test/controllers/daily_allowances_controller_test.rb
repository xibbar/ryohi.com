require 'test_helper'

class DailyAllowancesControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    login_user @user, signin_path
    @company = @user.companies.create(attributes_for(:company))
    @daily_allowance = @company.daily_allowances.create(attributes_for(:daily_allowance))
  end

  test "should get index" do
    get :index, params: {company_id: @company.id}
    assert_response :success
  end

  test "should get new" do
    get :new, params: {company_id: @company.id}
    assert_response :success
  end

  test "should create daily_allowance" do
    post :create, params: {daily_allowance: {name: @daily_allowance.name, one_day_allowance: @daily_allowance.one_day_allowance, accommodation_day_allowance: @daily_allowance.accommodation_day_allowance, return_day_allowance: @daily_allowance.return_day_allowance}, company_id: @company.id}
    assert_redirected_to company_daily_allowances_path(@company)
    assert_equal I18n.t('notice.create', model_name: DailyAllowance.model_name.human), flash[:notice]
  end

  test "should fail to create daily_allowance" do
    post :create, params: {daily_allowance: {name: nil}, company_id: @company.id}
    assert_template :new
    assert_equal I18n.t('cant_save'), flash[:alert]
  end

  test "should get edit" do
    get :edit, params: {id: @daily_allowance.id, company_id: @company.id}
    assert_response :success
  end

  test "should update daily_allowance" do
    post :update, params: {id: @daily_allowance.id, daily_allowance: {name: @daily_allowance.name, one_day_allowance: @daily_allowance.one_day_allowance, accommodation_day_allowance: @daily_allowance.accommodation_day_allowance, return_day_allowance: @daily_allowance.return_day_allowance}, company_id: @company.id}
    assert_redirected_to company_daily_allowances_path(@company)
    assert_equal I18n.t('notice.update', model_name: DailyAllowance.model_name.human), flash[:notice]
  end

  test "should fail to update daily_allowance" do
    post :update, params: {id: @daily_allowance.id, daily_allowance: {name: nil}, company_id: @company.id}
    assert_template :new
    assert_equal I18n.t('cant_save'), flash[:alert]
  end

  test "should destroy daily_allowance" do
    delete :destroy, params: {id: @daily_allowance.id, company_id: @company.id}
    assert_redirected_to company_daily_allowances_path(@company)
    assert_equal I18n.t('notice.destroy', model_name: DailyAllowance.model_name.human), flash[:notice]
  end
end
