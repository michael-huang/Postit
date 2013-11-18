PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new' # display rails form
  # post 'posts', to: 'posts#create'	# submit the form
  # get '/posts/:id/edit', to: 'post#edit'	# edit
  # patch '/posts/:id', to: 'posts@update'	# submit the edition

  resources :posts, except: [:destroy] do
    member do
      post :vote
    end


    # collection do
    #   get :archives # GET /posts/archives
    # end

  	resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
  end

  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:create]
end

# Option1:
# resources :votes, only: [:create]
# POST /votes => 'VotesController#create'
#   - needs two pieces of information

# Option2(which we use in the case):
# POST /posts/3/vote => 'PostdController#vote'
# POST /comments/4/vote => 'CommentsController#vote'
