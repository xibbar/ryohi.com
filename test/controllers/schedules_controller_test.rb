require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    login_user @user, signin_path
    @company = @user.companies.create(attributes_for(:company))
    @daily_allowance = @company.daily_allowances.create(attributes_for(:daily_allowance))
    @employee = @company.employees.create(attributes_for(:employee))
    @accommodation_charge = @company.accommodation_charges.create(attributes_for(:accommodation_charge))
    @schedule = create(:one_day_schedule, employee: @employee, daily_allowance: @daily_allowance)
  end

  test "should get index if target_month exist" do
    get :index, params: {target_month: "2023-01-01"}
    assert_response :success
  end

  test "should get index if target_month not exist" do
    get :index
    assert_response :success
  end

  test "should get new if date exist" do
    get :new, params: {date: "2023-02-01"}
    assert_response :success
  end

  test "should get new if date not exist" do
    get :new
    assert_response :success
  end

  test "should create schedule" do
    post :create, params: {schedule: {date: @schedule.date, days: 1, destination: @schedule.destination, business: @schedule.business, daily_allowance_id: @daily_allowance.id, employee_id: @employee.id, accommodation_charge_id: @accommodation_charge.id}}
    assert_redirected_to schedule_path(assigns(:schedule))
    assert_equal I18n.t('notice.create', model_name: Schedule.model_name.human), flash[:notice]
  end

  test "should fail to create schedule" do
    post :create, params: {schedule: {date: @schedule.date, days: 1}}
    assert_template :new
  end

  test "should show schedule" do
    get :show, params: {id: @schedule.id}
  end

  test "should get edit" do
    get :edit, params: {id: @schedule.id}
    assert_response :success
  end

  test "should update schedule" do
    patch :update, params: {id: @schedule.id, schedule: {date: @schedule.date}}
    assert_redirected_to schedule_path(@schedule)
    assert_equal I18n.t('notice.update', model_name: Schedule.model_name.human), flash[:notice]
  end

  test "should fail to update schedule" do
    patch :update, params: {id: @schedule.id, schedule: {destination: nil}}
    assert_template :edit
  end

  test "should destroy schedule" do
    assert_difference('Schedule.count', -1) do
      delete :destroy, params: {id: @schedule.id}
    end
    assert_redirected_to schedules_path
    assert_equal I18n.t('notice.destroy', model_name: Schedule.model_name.human), flash[:notice]
  end

  test "should get daily_allowances" do
    post :daily_allowances, params: {employee_id: @schedule.employee_id, format: :js}
    assert_response :success
    assert_not_nil @user.employees.find(@schedule.employee_id).company.daily_allowances
  end

  #test "should fail to get daily_allowances" do
  #  post :daily_allowances, format: :js
  #  assert_response :success
  #  #assert_template "$('#daily_allowances').html('')"
  #end

  test "should get accommodation_charges" do
    post :accommodation_charges, params: {employee_id: @schedule.employee_id, days: 2, format: :js}
    assert_response :success
    assert_not_nil @user.employees.find(@schedule.employee_id).company.accommodation_charges
  end

  test "should fail to get accommodation_charges" do
    post :accommodation_charges, format: :js
    assert_response :success
  end
end
