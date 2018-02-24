# frozen_string_literal: true
class StatsController < ApplicationController
  before_action :set_user

  def index
    @stats = policy_scope(Event).where(date: Date.current, user: @user).longest_duration(limit: 10)
  end

private

  def set_user
    @user = User.find(params[:user_id])
  end
end
