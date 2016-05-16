require 'test_helper'

class SuggestionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get favorite" do
    get :favorite
    assert_response :success
  end

  test "should get favorites" do
    get :favorites
    assert_response :success
  end

  test "should get unfavorite" do
    get :unfavorite
    assert_response :success
  end

end
