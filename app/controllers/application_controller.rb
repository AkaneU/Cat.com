class ApplicationController < ActionController::Base
  before_action :authenticate_end_user!, except: [:top], if: :public_url
  before_action :authenticate_admin!, if: :admin_url

  def public_url
    request.fullpath.exclude?("/admin")
  end

  def admin_url
    request.fullpath.include?("/admin")
  end

end
