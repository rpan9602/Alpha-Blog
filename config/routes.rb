# ref: http://guides.rubyonrails.org/routing.html#using-root
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # root route only routes GET requests to the action. should be on top always.
  root 'pages#home' ## or root to: 'pages#home'

  get 'about', to: 'pages#about' 
  
  resources :articles # see sample at bottom of the file for meaning
  
  get 'signup', to: 'users#new' # already define the route for new
  resources :users, except: [:new] # new route is defined above line
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create' # create a new seesion for login user
  delete 'logout', to: 'sessions#destroy'
  
  resources :categories, except: [:destroy]
  ### samples : (not related to this course)
  ### ======================================
  # get "users", to: "users#index"
  # http GET method, In this instance, gets a list of users

  # get "users/:id", to: "users#show"
  # In this instance, gets a specific user via the provided id.  For example: /users/3882

  # post "users", to: "users#create"
  # http POST method, In this instance, used for creating a user.

  # put "users/:id"
  # http PUT method, used for updating a resource, In this instance, updates the user.  
  # Older versions of Rails used this for all updates.

  # patch "users/:id"
  #  http PATCH method.  in this instance, used to partially update the user's information.

  # delete "users/:id"
  # http DELETE method.  In this instance, used to delete a user.
  
  ### resources :users 
	# generates:
	#   get "/users" -- index on your controller
	#   get "/users/:id" -- show on your controller
	#   get "/users/new" -- new method on your controller
	#   post "/users" -- create on your controller
	#   get "/users/:id/edit" -- edit method on your controller
	#   put "/users/:id" -- update on your controller
	#   patch "/users/:id" -- update on your controller
	#   delete "/users/:id" -- destroy on your controller
	
  ### resource :privacy_policy
	# generates:
	#   get "/privacy_policy" -- show on your controller
	#   get "/privacy_policy/new" -- new method on your controller
	#   post "/privacy_policy" -- create on your controller
	#   get "/privacy_policy/edit" -- edit method on your controller
	#   put "/privacy_policy" -- update on your controller
	#   patch "/privacy_policy" -- update on your controller
	#   delete "/privacy_policy" -- destroy on your controller	
	
  ### resources :users, except: [:show]
	# generates actions for everything except for get "/users/:id"

  ### resource :privacy_policy, only: [:show]
	# only generate the get "/privacy_policy route for the Privacy Policy.
	
  ### You can specify unicode character routes directly. For example:
	get 'こんにちは', to: 'welcome#index'
end
