class Admin::HomesController < ApplicationController

  def home
    @inquiries = Inquiry.all
  end

end
