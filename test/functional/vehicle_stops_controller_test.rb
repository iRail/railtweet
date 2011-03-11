require 'test_helper'

class VehicleStopsControllerTest < ActionController::TestCase
  setup do
    @vehicle_stop = vehicle_stops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicle_stops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle_stop" do
    assert_difference('VehicleStop.count') do
      post :create, :vehicle_stop => @vehicle_stop.attributes
    end

    assert_redirected_to vehicle_stop_path(assigns(:vehicle_stop))
  end

  test "should show vehicle_stop" do
    get :show, :id => @vehicle_stop.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @vehicle_stop.to_param
    assert_response :success
  end

  test "should update vehicle_stop" do
    put :update, :id => @vehicle_stop.to_param, :vehicle_stop => @vehicle_stop.attributes
    assert_redirected_to vehicle_stop_path(assigns(:vehicle_stop))
  end

  test "should destroy vehicle_stop" do
    assert_difference('VehicleStop.count', -1) do
      delete :destroy, :id => @vehicle_stop.to_param
    end

    assert_redirected_to vehicle_stops_path
  end
end
