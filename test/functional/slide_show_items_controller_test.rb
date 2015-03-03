require 'test_helper'

class SlideShowItemsControllerTest < ActionController::TestCase
  setup do
    @slide_show_item = slide_show_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slide_show_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slide_show_item" do
    assert_difference('SlideShowItem.count') do
      post :create, slide_show_item: { alternate_text: @slide_show_item.alternate_text, name: @slide_show_item.name, paperclip_id: @slide_show_item.paperclip_id, path: @slide_show_item.path, user_id: @slide_show_item.user_id }
    end

    assert_redirected_to slide_show_item_path(assigns(:slide_show_item))
  end

  test "should show slide_show_item" do
    get :show, id: @slide_show_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slide_show_item
    assert_response :success
  end

  test "should update slide_show_item" do
    put :update, id: @slide_show_item, slide_show_item: { alternate_text: @slide_show_item.alternate_text, name: @slide_show_item.name, paperclip_id: @slide_show_item.paperclip_id, path: @slide_show_item.path, user_id: @slide_show_item.user_id }
    assert_redirected_to slide_show_item_path(assigns(:slide_show_item))
  end

  test "should destroy slide_show_item" do
    assert_difference('SlideShowItem.count', -1) do
      delete :destroy, id: @slide_show_item
    end

    assert_redirected_to slide_show_items_path
  end
end
