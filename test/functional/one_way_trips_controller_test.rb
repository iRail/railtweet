require 'test_helper'

class OneWayTripsControllerTest < ActionController::TestCase
  setup do
    @one_way_trip = one_way_trips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:one_way_trips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create one_way_trip" do
    assert_difference('OneWayTrip.count') do
      post :create, :one_way_trip => @one_way_trip.attributes
    end

    assert_redirected_to one_way_trip_path(assigns(:one_way_trip))
  end

  test "should show one_way_trip" do
    get :show, :id => @one_way_trip.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @one_way_trip.to_param
    assert_response :success
  end

  test "should update one_way_trip" do
    put :update, :id => @one_way_trip.to_param, :one_way_trip => @one_way_trip.attributes
    assert_redirected_to one_way_trip_path(assigns(:one_way_trip))
  end

  test "should destroy one_way_trip" do
    assert_difference('OneWayTrip.count', -1) do
      delete :destroy, :id => @one_way_trip.to_param
    end

    assert_redirected_to one_way_trips_path
  end
end
