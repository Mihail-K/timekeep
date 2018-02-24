# frozen_string_literal: true
class StatsController < ApplicationController
  before_action :set_user
  before_action :set_date

  def index
    @stats = policy_scope(Event).where(date: @date, user: @user).longest_duration(limit: 10)
  end

private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_date
    @date = params[:date].presence || policy_scope(Event).where(user: @user).maximum(:date) || Date.current
  end
end
