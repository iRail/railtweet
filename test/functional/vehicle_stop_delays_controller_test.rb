require 'test_helper'

class VehicleStopDelaysControllerTest < ActionController::TestCase
  setup do
    @vehicle_stop_delay = vehicle_stop_delays(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicle_stop_delays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle_stop_delay" do
    assert_difference('VehicleStopDelay.count') do
      post :create, :vehicle_stop_delay => @vehicle_stop_delay.attributes
    end

    assert_redirected_to vehicle_stop_delay_path(assigns(:vehicle_stop_delay))
  end

  test "should show vehicle_stop_delay" do
    get :show, :id => @vehicle_stop_delay.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @vehicle_stop_delay.to_param
    assert_response :success
  end

  test "should update vehicle_stop_delay" do
    put :update, :id => @vehicle_stop_delay.to_param, :vehicle_stop_delay => @vehicle_stop_delay.attributes
    assert_redirected_to vehicle_stop_delay_path(assigns(:vehicle_stop_delay))
  end

  test "should destroy vehicle_stop_delay" do
    assert_difference('VehicleStopDelay.count', -1) do
      delete :destroy, :id => @vehicle_stop_delay.to_param
    end

    assert_redirected_to vehicle_stop_delays_path
  end
end
