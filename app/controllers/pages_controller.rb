class PagesController < ApplicationController
  def profile
    @user = current_user
  end

  def chat
  end
end
