require 'test_helper'

class Admin::NatureOfReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_nature_of_review = admin_nature_of_reviews(:one)
  end

  test "should get index" do
    get admin_nature_of_reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_nature_of_review_url
    assert_response :success
  end

  test "should create admin_nature_of_review" do
    assert_difference('Admin::NatureOfReview.count') do
      post admin_nature_of_reviews_url, params: { admin_nature_of_review: { review_type: @admin_nature_of_review.review_type, title: @admin_nature_of_review.title, user_id: @admin_nature_of_review.user_id } }
    end

    assert_redirected_to admin_nature_of_review_url(Admin::NatureOfReview.last)
  end

  test "should show admin_nature_of_review" do
    get admin_nature_of_review_url(@admin_nature_of_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_nature_of_review_url(@admin_nature_of_review)
    assert_response :success
  end

  test "should update admin_nature_of_review" do
    patch admin_nature_of_review_url(@admin_nature_of_review), params: { admin_nature_of_review: { review_type: @admin_nature_of_review.review_type, title: @admin_nature_of_review.title, user_id: @admin_nature_of_review.user_id } }
    assert_redirected_to admin_nature_of_review_url(@admin_nature_of_review)
  end

  test "should destroy admin_nature_of_review" do
    assert_difference('Admin::NatureOfReview.count', -1) do
      delete admin_nature_of_review_url(@admin_nature_of_review)
    end

    assert_redirected_to admin_nature_of_reviews_url
  end
end
