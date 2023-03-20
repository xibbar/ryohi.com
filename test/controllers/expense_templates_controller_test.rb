require 'test_helper'

class ExpenseTemplatesControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    login_user @user, signin_path
    @company = @user.companies.create(attributes_for(:company))
    @expense_template = @company.expense_templates.create(attributes_for(:expense_template))
  end

  test "should get index" do
    get :index, params: {company_id: @company.id}
    assert_response :success
  end

  test "should get new" do
    get :new, params: {company_id: @company.id}
    assert_response :success
  end

  test "should create expense_template" do
    expense_template = build(:expense_template)
    post :create, params: {expense_template: {section: expense_template.section, round: expense_template.round, way: expense_template.way, price: expense_template.price}, company_id: @company.id}
    assert_redirected_to company_expense_templates_path(@company)
    assert_equal I18n.t('notice.create', model_name: ExpenseTemplate.model_name.human), flash[:notice]
  end

  test "should fail to create expense_template" do
    post :create, params: {expense_template: {section: @expense_template.section}, company_id: @company.id}
    assert_template :new
    assert_equal I18n.t('cant_save'), flash[:alert]
  end

  test "should get edit" do
    get :edit, params: {id: @expense_template.id, company_id: @company.id}
    assert_response :success
  end

  test "should update expense_template" do
    post :update, params: {id: @expense_template.id, expense_template: {section: @expense_template.section, round: @expense_template.round, way: @expense_template.way, price: @expense_template.price}, company_id: @company.id}
    assert_redirected_to company_expense_templates_path(@company)
    assert_equal I18n.t('notice.update', model_name: ExpenseTemplate.model_name.human), flash[:notice]
  end

  test "should fail to update expense_template" do
    post :update, params: {id: @expense_template.id, expense_template: {section: nil}, company_id: @company.id}
    assert_template :new
    assert_equal I18n.t('cant_save'), flash[:alert]
  end

  test "should destroy expense_template" do
    delete :destroy, params: {id: @expense_template, company_id: @company.id}
    assert_redirected_to company_expense_templates_path(@company)
    assert_equal I18n.t('notice.destroy', model_name: ExpenseTemplate.model_name.human), flash[:notice]
  end
end
