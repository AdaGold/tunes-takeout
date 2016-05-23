require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  describe "Food" do
    before do
      @intance_of_food = Food.find_in_api("seattle-yoga-lounge-seattle")
    end

    it "knows that it has an image url", :vcr do
      assert_instance_of String, @intance_of_food.the_image_url
    end

    it "knows its name", :vcr do
      assert_equal "Seattle Yoga Lounge", @intance_of_food.name
    end

    it "knows its rating", :vcr do
      assert_equal 3.5, @intance_of_food.rating
      assert_instance_of Fixnum, @intance_of_food.review_count
    end

    it "knows its review_count", :vcr do
      assert_equal 92, @intance_of_food.review_count
      assert_instance_of Fixnum, @intance_of_food.review_count
    end

    it "knows its rating_img_url_large", :vcr do
      assert_instance_of String, @intance_of_food.rating_img_url_large
    end

    it "knows its categories", :vcr do
      assert_instance_of Array, @intance_of_food.categories
    end

    it "knows its location", :vcr do
      assert_instance_of Array, @intance_of_food.location
    end

    it "knows its display_phone", :vcr do
      assert_equal "+1-206-523-4569", @intance_of_food.display_phone
      assert_instance_of String, @intance_of_food.display_phone
    end

    it "knows that it has an open in Yelp url", :vcr do
      assert_instance_of String, @intance_of_food.open_yelp_url
    end
  end
end
