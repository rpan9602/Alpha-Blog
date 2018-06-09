require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    # this won't hit the dev/prod database, but test database.
    # test database will be cleaned after every tests.
    @category = Category.new(name: "sports")
  end
  
  # first test case
  test "category should be valid" do
    assert @category.valid?
  end
  
  # model should validate name
  test "name should  be present" do
    @category.name = ""
    assert_not @category.valid?
  end
  
  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end
  
  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
  
  test "name should not be too short" do
    @category.name = "as"
    assert_not @category.valid?
  end
end