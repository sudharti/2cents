class PostsController < ApplicationController

  before_action :set_post, only: [:show, :update, :destroy]
  before_action :check_user,  only: [:update, :destroy]
  before_action :authenticate_user!

  def create
    @post = Post.create(post_params) do |post|
      post.user = current_user
      post.location = current_user.location
    end

    respond_to do |format|
      format.js
    end
  end

  def show
    @comments = @post.comments.paginate(page: params[:page]).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @post.update(post_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post_id = params[:id]
    @post.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def check_user
    if @post.user != current_user
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    end
  end

  def post_params
    params.require(:post).permit(:content, :location, category_ids: [])
  end

end
