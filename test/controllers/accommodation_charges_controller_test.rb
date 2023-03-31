require 'test_helper'

class AccommodationChargesControllerTest < ActionController::TestCase
  setup do
    #@accommodation_charge = accommodation_charges(:one)
    @user = create(:user)
    @company = @user.companies.create(attributes_for(:company))
    @accommodation_charge = @company.accommodation_charges.create(attributes_for(:accommodation_charge))
    login_user @user, signin_path
  end

  test "should get index" do
    get :index, params: {company_id: @company.id}
    assert_response :success
    assert_not_nil assigns(:accommodation_charges)
  end

  test "should get new" do
    get :new, params: {company_id: @company.id}
    assert_response :success
  end

  test "should create accommodation_charge" do
    assert_difference('AccommodationCharge.count', 1) do
      post :create, params: {accommodation_charge: { amount: @accommodation_charge.amount, company_id: @accommodation_charge.company_id, name: @accommodation_charge.name }, company_id: @company.id}
    end

    assert_redirected_to company_accommodation_charges_path(@company)
  end

  test "should fail to create accommodation_charge" do
    assert_difference('AccommodationCharge.count', 0) do
      post :create, params: {accommodation_charge: { amount: @accommodation_charge.amount, company_id: @accommodation_charge.company_id, name: nil }, company_id: @company.id}
    end
    assert_template :new
  end

  test "should show accommodation_charge" do
    get :show, params: {id: @accommodation_charge, company_id: @company.id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: {id: @accommodation_charge, company_id: @company.id}
    assert_response :success
  end

  test "should update accommodation_charge" do
    patch :update, params: {id: @accommodation_charge, accommodation_charge: { amount: @accommodation_charge.amount, company_id: @accommodation_charge.company_id, name: @accommodation_charge.name }, company_id: @company.id}
    assert_redirected_to company_accommodation_charges_path(@company)
  end

  test "should fail to update accommodation_charge" do
    patch :update, params: {id: @accommodation_charge, accommodation_charge: { amount: @accommodation_charge.amount, company_id: @accommodation_charge.company_id, name: nil }, company_id: @company.id}
    assert_template :new
    assert_equal I18n.t('cant_save'), flash[:alert]
  end

  test "should destroy accommodation_charge" do
    assert_difference('AccommodationCharge.count', -1) do
      delete :destroy, params: {id: @accommodation_charge, company_id: @company.id}
    end

    assert_redirected_to company_accommodation_charges_path(@company)
  end
end
