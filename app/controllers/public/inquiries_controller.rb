class Public::InquiriesController < ApplicationController

  def new
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.invalid?
      render :new
    end
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if params[:back]
      render :new and return
    else
      @inquiry.end_user = current_end_user
      @inquiry.save
      flash[:notice] = "問い合わせが完了しました"
      redirect_to end_user_path(current_end_user.id)
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :title, :text)
  end

end
