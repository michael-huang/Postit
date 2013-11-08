class PostsController < ApplicationController
  def index
  	@posts = Post.all
  end

  def show
  	@post = Post.find(params[:id])
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)

  	if @post.save
  		flash[:notice] = 'Your post was created.'
  		redirect_to posts_path
  	else # validation error, we can display error messages
  		render 'new' # which you submitted this action from
  	end
  end

	def edit
  	
  end

  def update

  end

	def post_params
		params.require(:post).permit!
	end

end
