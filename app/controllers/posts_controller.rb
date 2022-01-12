class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /posts
  def index
  @posts = Post.all.order("created_at DESC")
  @post = Post.new
  @users=User.all
  end

  def show
    @posts=Post.all.order("created_at DESC")
    @users=User.all
  end

  def new
    @post=current_user.posts.build
  end

  def edit
    @posts=Post.all.order("created_at DESC")
    @users=User.all
  end

  def create
    @post=current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
      format.html {redirect_to root_path, notice: 'Post created successfully'}
    else
      @posts = Posts.all
      flash[:alert] = @post.errors.count
      format.html {render :index, alert: 'Post failed'}
    end
  end
end

def update
  respond_to do |format|
    if @post.update(post_params)
    format.html {redirect_to root_path, notice: 'Post created successfully'}
  else
    @posts = Posts.all
    flash[:alert] = @post.errors.count
    format.html {render :index, alert: 'Post failed'}
  end
end

def destroy
  @post.destroy
  respond_to do |format|
    format.html {redirect_to posts_url, notice: "Post was successfully destroyed."}
  end
end
end

private
  def set_post
    @post=Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
