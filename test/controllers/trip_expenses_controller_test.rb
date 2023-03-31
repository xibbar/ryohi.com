require 'test_helper'

class TripExpensesControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    login_user @user, signin_path
    @company = @user.companies.create(attributes_for(:company))
    @daily_allowance = @company.daily_allowances.create(attributes_for(:daily_allowance))
    @employee = @company.employees.create(attributes_for(:employee))
    @expense_template = @company.expense_templates.create(attributes_for(:expense_template))
    @schedule = create(:one_day_schedule, employee: @employee, daily_allowance: @daily_allowance)
    @trip_expense = create(:trip_expense, schedule: @schedule)
  end

  test "should get new" do
    get :new, params: {schedule_id: @schedule.id}
    assert_response :success
  end

  test "should create trip_expense" do
    post :create, params: {schedule_id: @schedule.id, trip_expense: {section: @trip_expense.section, round: @trip_expense.round, way: @trip_expense.way, price: @trip_expense.price}}
    assert_redirected_to schedule_path(@schedule)
    assert_equal I18n.t('notice.create', model_name: TripExpense.model_name.human), flash[:notice]
  end

  test "should fail to create trip_expense" do
    post :create, params: {schedule_id: @schedule.id, trip_expense: {section: nil}}
    assert_template :new
  end

  test "should get edit" do
    get :edit, params: {schedule_id: @schedule.id, id: @trip_expense.id}
    assert_response :success
  end

  test "should update trip_expense" do
    patch :update, params: {schedule_id: @schedule.id, id: @trip_expense.id, trip_expense: {section: @trip_expense.section}}
    assert_redirected_to schedule_path(@schedule)
    assert_equal I18n.t('notice.update', model_name: TripExpense.model_name.human), flash[:notice]
  end

  test "should fail to update trip_expense" do
    patch :update, params: {schedule_id: @schedule.id, id: @trip_expense.id, trip_expense: {section: nil}}
    assert_template :edit
  end

  test "should destroy trip_expense" do
    delete :destroy, params: {schedule_id: @schedule.id, id: @trip_expense.id}
    assert_redirected_to schedule_path(@schedule)
    assert_equal I18n.t('notice.destroy', model_name: TripExpense.model_name.human), flash[:notice]
  end

  test "should render valid expense_template" do
    post :merge_template, params: {schedule_id: @schedule.id, expense_template_id: @expense_template.id}
    json_response = JSON.parse(response.body)
    assert_equal @expense_template.section, json_response["section"]
    assert_equal @expense_template.round, json_response["round"]
    assert_equal @expense_template.way, json_response["way"]
    assert_equal @expense_template.price, json_response["price"]
  end

  test "should render invalid expense_template" do
    post :merge_template, params: {schedule_id: @schedule.id}
    json_response = JSON.parse(response.body)
    assert_equal "", json_response["section"]
    assert_equal true, json_response["round"]
    assert_equal "", json_response["way"]
    assert_equal "", json_response["price"]
  end

  test "should add expense_template" do
    get :add_template, params: {schedule_id: @schedule.id, id: @trip_expense.id}
    assert_redirected_to schedule_path(@schedule)
    assert_equal I18n.t('notice.add', model_name: ExpenseTemplate.model_name.human), flash[:notice]
  end

  test "should fail to add expense_template" do
    @trip_expense.update(section: @expense_template.section)
    get :add_template, params: {schedule_id: @schedule.id, id: @trip_expense.id}
    assert_redirected_to schedule_path(@schedule)
    assert_equal I18n.t('alert.taken'), flash[:alert]
  end
end
