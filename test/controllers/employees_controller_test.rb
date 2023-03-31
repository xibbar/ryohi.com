require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    login_user @user, signin_path
    @company = @user.companies.create(attributes_for(:company))
    @employee = @company.employees.create(attributes_for(:employee))
  end

  #test "should get index" do
  #  get :index, company_id: @company.id
  #  assert_response :success
  #end

  #test "should get new" do
  #  get :new, company_id: @company.id, format: :js
  #  assert_response :success
  #end

  test "should create employee" do
    post :create, params: {company_id: @company, employee: {name: @employee.name}, format: 'js'}
    assert_equal I18n.t('notice.create', model_name: Employee.model_name.human), flash[:notice]
  end

  #test "should get edit" do
  #  get :edit, id: @employee.id, company_id: @company.id, format: 'js'
  #  assert_response :success
  #end
end
