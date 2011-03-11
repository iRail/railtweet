require 'test_helper'

class ConnectionStopsControllerTest < ActionController::TestCase
  setup do
    @connection_stop = connection_stops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:connection_stops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create connection_stop" do
    assert_difference('ConnectionStop.count') do
      post :create, :connection_stop => @connection_stop.attributes
    end

    assert_redirected_to connection_stop_path(assigns(:connection_stop))
  end

  test "should show connection_stop" do
    get :show, :id => @connection_stop.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @connection_stop.to_param
    assert_response :success
  end

  test "should update connection_stop" do
    put :update, :id => @connection_stop.to_param, :connection_stop => @connection_stop.attributes
    assert_redirected_to connection_stop_path(assigns(:connection_stop))
  end

  test "should destroy connection_stop" do
    assert_difference('ConnectionStop.count', -1) do
      delete :destroy, :id => @connection_stop.to_param
    end

    assert_redirected_to connection_stops_path
  end
end
