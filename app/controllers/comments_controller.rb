class CommentsController < ApplicationController
	def create
		


  @post = Post.find(params[:post_id])
  @comment = @post.comments.create(params[:comment].permit(:name, :body))
  @comment.user_id = current_user.id 
  if @comment.save
    redirect_to post_path(@post)
  else
    flash.now[:danger] = "error"
  end


end
	def destroy 
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to post_path(@post)
	end


	private
	def comment_params
		params.require(:comment).permit(:name, :body).merge(user_id: current_user.id)
		
	end
end
