require 'test_helper'

class AccommodationChargesControllerTest < ActionController::TestCase
  setup do
    @accommodation_charge = accommodation_charges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accommodation_charges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accommodation_charge" do
    assert_difference('AccommodationCharge.count') do
      post :create, accommodation_charge: { amount: @accommodation_charge.amount, company_id: @accommodation_charge.company_id, name: @accommodation_charge.name }
    end

    assert_redirected_to accommodation_charge_path(assigns(:accommodation_charge))
  end

  test "should show accommodation_charge" do
    get :show, id: @accommodation_charge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accommodation_charge
    assert_response :success
  end

  test "should update accommodation_charge" do
    patch :update, id: @accommodation_charge, accommodation_charge: { amount: @accommodation_charge.amount, company_id: @accommodation_charge.company_id, name: @accommodation_charge.name }
    assert_redirected_to accommodation_charge_path(assigns(:accommodation_charge))
  end

  test "should destroy accommodation_charge" do
    assert_difference('AccommodationCharge.count', -1) do
      delete :destroy, id: @accommodation_charge
    end

    assert_redirected_to accommodation_charges_path
  end
end
