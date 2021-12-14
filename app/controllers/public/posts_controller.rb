class Public::PostsController < ApplicationController


  def index
  end

  def timeline
  end

  def show
    @post = Post.includes(:image_files).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    binding.pry
    @post.end_user = current_end_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :tag_list, image_files_images: [])
  end

end
