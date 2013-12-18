require 'test_helper'

class InfolinksControllerTest < ActionController::TestCase
  setup do
    @infolink = infolinks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:infolinks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create infolink" do
    assert_difference('Infolink.count') do
      post :create, infolink: { frompiece_id: @infolink.frompiece_id, topiece_id: @infolink.topiece_id }
    end

    assert_redirected_to infolink_path(assigns(:infolink))
  end

  test "should show infolink" do
    get :show, id: @infolink
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @infolink
    assert_response :success
  end

  test "should update infolink" do
    put :update, id: @infolink, infolink: { frompiece_id: @infolink.frompiece_id, topiece_id: @infolink.topiece_id }
    assert_redirected_to infolink_path(assigns(:infolink))
  end

  test "should destroy infolink" do
    assert_difference('Infolink.count', -1) do
      delete :destroy, id: @infolink
    end

    assert_redirected_to infolinks_path
  end
end
