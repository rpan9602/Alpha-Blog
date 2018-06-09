require 'test_helper'

### class CategoriesControllerTest < ActionController::TestCase # rails 4
class CategoriesControllerTest < ActionDispatch::IntegrationTest # rails 5
  def setup
    @category = Category.create(name: "sports") # using create to hit test databse, instead of new
  end

  test "should get categories index" do
    ### get :index	# rails 4
    get categories_path 	# rails 5
    assert_response :success
  end
  
  test "should get new" do
    ### get :new	# rails 4
    get new_category_path 	# rails 5
    assert_response :success
  end
  
  test "should get show" do
    ### get :show	# rails 4. this line won't work since needing an instance id
    ### get(:show, {'id' => @category.id}) #rails 4 way to work
    
    ## get category_path 	# rails 5 this line won't work, need an instance object.
    get category_path(@category) 	# rails 5
    assert_response :success
  end
end 