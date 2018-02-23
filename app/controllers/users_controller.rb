# frozen_string_literal: true
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @session = Session.create(user: @user)
      session[:token] = @session.token
      redirect_to user_events_url(@user)
    else
      render 'new'
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
