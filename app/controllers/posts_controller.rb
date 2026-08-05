class PostsController < ApplicationController
  before_action :require_user, except: [ :index, :show ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
    @post.tags.build
  end

  def edit
    @post = Post.find(params[:id])
    existing_tags = @post.tag_list
    @post.tags.destroy_all
    @post.tags.build(name: existing_tags)
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
    params.require(:post).permit(
      :title,
      :content,
      tags_attributes: [ :id, :name, :_destroy ]
    )
  end
end
