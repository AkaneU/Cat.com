class Public::PostCommentsController < ApplicationController
  before_action :ensure_end_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    post_comment = current_end_user.post_comments.new(post_comment_params)
    post_comment.post_id = @post.id
    if post_comment.save
      @post.create_notification_comment!(current_end_user, post_comment.id)
    end
    redirect_back(fallback_location: post_path(@post))
  end

  def destroy
    @post = Post.find(params[:post_id])
    post_comment = @post.post_comments.find(params[:id])
    post_comment.destroy
  end

  private

  def ensure_end_user
    @post.post_comment.end_user != current_end_user
    redirect_to end_user_path(current_end_user)
  end


  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
