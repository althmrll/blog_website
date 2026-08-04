class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to @post, notice: "Comment added successfully!"
    else
      redirect_to @post, alert: "Comment couldn't be created."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
