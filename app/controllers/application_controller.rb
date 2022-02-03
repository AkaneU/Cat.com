class ApplicationController < ActionController::Base
  #ログインを行っていない場合、トップページを以外のアクセスを制限
  before_action :authenticate_end_user!, except: [:top], if: :public_url
  #管理者としてログインしていない時、管理者機能のページへのアクセスを制限
  before_action :authenticate_admin!, if: :admin_url

  def public_url
    request.fullpath.exclude?("/admin")
  end

  def admin_url
    request.fullpath.include?("/admin")
  end

end
