class Admin::InquiriesController < ApplicationController
  def show
    @inquiry = Inquiry.find(params[:id])
  end
end
