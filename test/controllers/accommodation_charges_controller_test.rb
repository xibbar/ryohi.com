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
    get :index, company_id: @company.id
    assert_response :success
    assert_not_nil assigns(:accommodation_charges)
  end

  test "should get new" do
    get :new, company_id: @company.id
    assert_response :success
  end

  test "should create accommodation_charge" do
    assert_difference('AccommodationCharge.count') do
      post :create, accommodation_charge: { amount: @accommodation_charge.amount, company_id: @accommodation_charge.company_id, name: @accommodation_charge.name }, company_id: @company.id
    end

    assert_redirected_to company_accommodation_charges_path(@company)
  end

  test "should show accommodation_charge" do
    get :show, id: @accommodation_charge, company_id: @company.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accommodation_charge, company_id: @company.id
    assert_response :success
  end

  test "should update accommodation_charge" do
    patch :update, id: @accommodation_charge, accommodation_charge: { amount: @accommodation_charge.amount, company_id: @accommodation_charge.company_id, name: @accommodation_charge.name }, company_id: @company.id
    assert_redirected_to company_accommodation_charges_path(@company)
  end

  test "should destroy accommodation_charge" do
    assert_difference('AccommodationCharge.count', -1) do
      delete :destroy, id: @accommodation_charge, company_id: @company.id
    end

    assert_redirected_to company_accommodation_charges_path(@company)
  end
end
