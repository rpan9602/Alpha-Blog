require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get new_category_path # emulating user action
    
    # In rails 5, assert_template has been moved to  gem. So add the gem
    # 'rails-controller-testing' to your Gemfile and run 'bundle install' before
    # you can use this method.
    assert_template 'categories/new'
    assert_response :success
    
    assert_difference 'Category.count', 1 do
      #post_via_redirect categories_path, category: {name: "sports"}  #rails 4
      
      # rails 5:
      post categories_path, params: {category: { name: "sports" } }
      follow_redirect!
      
      #assert_equal "/categories", categories_path # categories_path is redirected to from Create/if
      assert_template 'categories/index'
      assert_equal Category.create_success_message, flash[:success]
      assert_match "sports", response.body
    end
    
    #assert_equal "/categories", categories_path
    #assert_equal 'Category was created successfully', flash[:notice]
    #assert_match "sports", response.body
  end 
  
  test " invalid category submission results in failure" do
    get new_category_path
    
    # In rails 5, assert)template has been moved to  gem. So add the gem
    # 'rails-controller-testing' to your Gemfile and run 'bundle install' before
    # you can use this method.
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      #post_via_redirect categories_path, category: {name: "sports"}  #rails 4
      
      # rails 5:
      post categories_path, params: { category: { name:" " } }
      
      #assert_equal 'categories/new', new_category_path # new_category_path is from Create/else.
      assert_template 'categories/new'
      assert_select 'h2.panel-title'
      assert_select 'div.panel-body'
      
    end
    #assert_template 'categoies/new'
    
    # below h2.panel-title and div.panel-body come from view/shared/_errors.html.erb
    # this is because we're giving name: " " at line 33 above to test CategoriesController.Create method.
    # and save will return false there, and try to render new,  that will display error messages to be
    # displayed by _errors.html.erb.
    #assert_select 'h2.panel-title'
    #assert_select 'div.panel-body'
  end
end