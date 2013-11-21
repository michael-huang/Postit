class CommentsController < ApplicationController
	before_action :require_user
	
	def create
		@post = Post.find_by(slug: params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = current_user

		if @comment.save
			flash[:notice] = 'Your comment was added.'
			redirect_to post_path(@post)
		else
			render 'posts/show' 
		end	
	end

	def vote
		post = Post.find_by(slug: params[:post_id])
		@comment = Comment.find(params[:id])
		@comment.post = post
		@vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    # if vote.valid?
    #   flash[:notice] = "Your vote was counted."
    # else
    #   flash[:error] = "You can only vote for <strong>that</strong> once.".html_safe
    # end

    # redirect_to :back

    respond_to do |format|
    	format.html {redirect_to :back, notice: "Your vote was counted."}
    	format.js
    end
	end

end