require 'test_helper'

class BwimagesControllerTest < ActionController::TestCase
  setup do
    @bwimage = bwimages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bwimages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bwimage" do
    assert_difference('Bwimage.count') do
      post :create, bwimage: { name: @bwimage.name }
    end

    assert_redirected_to bwimage_path(assigns(:bwimage))
  end

  test "should show bwimage" do
    get :show, id: @bwimage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bwimage
    assert_response :success
  end

  test "should update bwimage" do
    put :update, id: @bwimage, bwimage: { name: @bwimage.name }
    assert_redirected_to bwimage_path(assigns(:bwimage))
  end

  test "should destroy bwimage" do
    assert_difference('Bwimage.count', -1) do
      delete :destroy, id: @bwimage
    end

    assert_redirected_to bwimages_path
  end
end
