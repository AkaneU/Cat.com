class Public::PostsController < ApplicationController

  def index
    @posts = Post.where(end_user_id: current_end_user.id)
  end

  def timeline
    @posts = Post.where(end_user_id: [current_end_user.id, *current_end_user.following_ids])
  end

  def new_posts
    @posts = Post.order(created_at: :desc)
  end

  def this_week_popular
    @posts = Post.joins(:favorites).where(favorites: {created_at: Time.current.all_week}).group(:post_id).order('count(end_user_id) desc').limit(50)
      @posts.each do |post|
        post = Post.includes(:image_files)
      end
  end

  def this_month_popular
     @posts = Post.joins(:favorites).where(favorites: {created_at: Time.current.all_month}).group(:post_id).order('count(end_user_id) desc').limit(50)
      @posts.each do |post|
        post = Post.includes(:image_files)
      end
  end

  def last_month_popular
     @posts = Post.joins(:favorites).where(favorites: {created_at: Time.current.last_month.all_month}).group(:post_id).order('count(end_user_id) desc').limit(50)
      @posts.each do |post|
        post = Post.includes(:image_files)
      end
  end

  def favorited
    favorites = Favorite.where(end_user_id: current_end_user.id).pluck(:post_id)
    @posts = Post.find(favorites)
  end

  def show
    @post = Post.includes(:image_files).find(params[:id])
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user = current_end_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post =Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
  end

  
  private

  def post_params
    params.require(:post).permit(:title, :text, :tag_list, image_files_images: [])
  end

end
