# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  before_action :reject_end_user, only: [:create]

  protected

  #ログインを行おうとしているエンドユーザーが退会済みか否かを判定し退会済みなら新規登録画面に遷移
  def reject_end_user
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    return if !@end_user
    if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
      flash[:notice] = "退会済みです<br>再度ご登録ください"
      redirect_to new_end_user_registration_path
    elsif @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == false)
      return if !@end_user
    else
      flash[:notice] = "入力が間違っています"
      redirect_back(fallback_location: new_end_user_session_path)
    end
  end

  def after_sign_in_path_for(resource)
    end_user_path(resource)
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

