class Public::PostsController < ApplicationController
  before_action :ensure_end_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.where(end_user_id: current_end_user.id).page(params[:page]).per(10)
  end

  def timeline
    @posts = Post.where(end_user_id: [current_end_user.id, *current_end_user.following_ids]).page(params[:page]).per(10)
  end

  def new_posts
    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
  end

  def posts_with_tag
    @posts =Post.tagged_with(params[:id]).page(params[:page]).per(10)
  end

  def this_week_popular
    posts = Post.find(Favorite.group(:post_id).where(favorites: {created_at: Time.current.all_week}).group(:post_id).order('count(post_id) desc').pluck(:post_id))
    @posts = Kaminari.paginate_array(posts).limit(50).page(params[:page]).per(10)

    #@posts = Post.joins(:favorites).where(favorites: {created_at: Time.current.all_week}).group(:post_id).order(favorited_end_users: :desc).limit(50).page(params[:page]).per(10)
    #@posts.each do |post|
    #  post = Post.includes(:image_files)
    #end
  end

  def this_month_popular
    posts = Post.find(Favorite.group(:post_id).where(favorites: {created_at: Time.current.all_month}).group(:post_id).order('count(post_id) desc').pluck(:post_id))
    @posts = Kaminari.paginate_array(posts).limit(50).page(params[:page]).per(10)
    #@posts = Post.joins(:favorites).where(favorites: {created_at: Time.current.all_month}).group(:post_id).order(favorited_end_users: :desc).limit(50).page(params[:page]).per(10)
    #@posts.each do |post|
    #  post = Post.includes(:image_files)
    #end
  end

  def last_month_popular
    posts = Post.find(Favorite.group(:post_id).where(favorites: {created_at: Time.current.last_month.all_month}).group(:post_id).order('count(post_id) desc').pluck(:post_id))
    @posts = Kaminari.paginate_array(posts).limit(50).page(params[:page]).per(10)
    #@posts = Post.joins(:favorites).where(favorites: {created_at: Time.current.last_month.all_month}).group(:post_id).order(favorited_end_users: :desc).limit(50).page(params[:page]).per(10)
    #@posts.each do |post|
    #  post = Post.includes(:image_files)
    #end
  end

  def favorited
    @posts = Post.where(favorites: current_end_user.favorites).page(params[:page]).per(10)
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
      flash[:notice] = "投稿が完了しました"
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
    flash[:notice] = "投稿が編集されました"
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to timeline_path
  end


  private

  def ensure_end_user
    @post = Post.find(params[:id])
    @post.end_user != current_end_user
    redirect_to end_user_path(current_end_user)
  end

  def post_params
    params.require(:post).permit(:title, :text, :tag_list, image_files_images: [])
  end

end
