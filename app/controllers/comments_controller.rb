class CommentsController < ApplicationController
  def edit
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to @post, notice: "Comment added successfully!"
    else
      redirect_to @post, alert: "Comment couldn't be created."
    end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @post, notice: "Comment was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @comment.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @comment.destroy!
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Comment was successfully deleted.", status: :see_other }
      format.json { head :no_content }
    end
  end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
