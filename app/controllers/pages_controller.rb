class PagesController < ApplicationController
  def profile
    @user = current_user
  end
end
