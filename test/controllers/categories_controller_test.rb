require 'test_helper'

### class CategoriesControllerTest < ActionController::TestCase # rails 4
class CategoriesControllerTest < ActionDispatch::IntegrationTest # rails 5
  def setup
    print "setup called\n"
    @category = Category.create(name: "sports") # using create to hit test databse, instead of new
  end

  test "should get categories index" do
    print "get categories\n"
    ### get :index	# rails 4
    get categories_path 	# rails 5
    assert_response :success
  end
  
  test "should get new" do
    print "get new\n"
    ### get :new	# rails 4
    get new_category_path 	# rails 5
    assert_response :success
  end
  
  test "should get show" do
    print "get show \n"
    ### get :show	# rails 4. this line won't work since needing an instance id
    ### get(:show, {'id' => @category.id}) #rails 4 way to work
    
    ## get category_path 	# rails 5 this line won't work, need an instance object.
    get category_path(@category) 	# rails 5
    assert_response :success
  end
  
  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      # mean no logged in user
      post "/categories", params: {category: { name: "sports" } }
      assert_response :success
      
      assert_template '/categories/new'
      #assert_template :new
    
      #assert_redirected_to new_category_path
    end
    assert_response :success
    # should redirect now.
    #assert_redirect_to categories_path
  end  
end 