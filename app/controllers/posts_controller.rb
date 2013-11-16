class PostsController < ApplicationController

  # There are two purpose for before_action
  # 1. set up something
  # 2. redirect away from action

  before_action :set_post, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]

  def index
  	@posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
    @post.creator = current_user

  	if @post.save
  		flash[:notice] = 'Your post was created.'
  		redirect_to posts_path
  	else # validation error, we can display error messages
  		render :new # which you submitted this action from
  	end
  end

	def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

	def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
		
    # if you require all the params, you can just simply type following
    # params.require(:post).permit!
	end

def set_post
  @post = Post.find(params[:id])
end

end
