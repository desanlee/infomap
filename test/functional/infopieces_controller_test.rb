require 'test_helper'

class InfopiecesControllerTest < ActionController::TestCase
  setup do
    @infopiece = infopieces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:infopieces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create infopiece" do
    assert_difference('Infopiece.count') do
      post :create, infopiece: { content: @infopiece.content, user_id: @infopiece.user_id }
    end

    assert_redirected_to infopiece_path(assigns(:infopiece))
  end

  test "should show infopiece" do
    get :show, id: @infopiece
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @infopiece
    assert_response :success
  end

  test "should update infopiece" do
    put :update, id: @infopiece, infopiece: { content: @infopiece.content, user_id: @infopiece.user_id }
    assert_redirected_to infopiece_path(assigns(:infopiece))
  end

  test "should destroy infopiece" do
    assert_difference('Infopiece.count', -1) do
      delete :destroy, id: @infopiece
    end

    assert_redirected_to infopieces_path
  end
end
