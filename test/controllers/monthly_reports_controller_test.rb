require 'test_helper'

class MonthlyReportsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    login_user @user, signin_path
    @company = create(:company, user: @user)
    @employee = create(:employee, company: @company)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, params: {employee_id: @employee.id}
    assert_response :success
  end
end
