class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @apartments = @user.apartments.order(created_at: :desc)
  end
end
