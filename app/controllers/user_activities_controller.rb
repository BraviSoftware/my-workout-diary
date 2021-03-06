class UserActivitiesController < ApplicationController
  def index
    @activity_types = ActivityType.all
    @activities = UserActivity.all_by_date(params[:username], params[:year], params[:month], params[:day])
    @user_exists = User.exists? username: params[:username]
    @user_name = User.where(:username => params[:username]).first.name if @user_exists
  end

  def all_users_by_date
    load_all_users_by_date
  end

  def all_users_by_date_charts
    load_all_users_by_date
  end

  private
  def load_all_users_by_date
    @activity_types = ActivityType.all
    @users_activities = UserActivity.all_users_by_date(params[:year], params[:month])
                                                          .joins('LEFT OUTER JOIN users ON users.id = activities.user_id')
                                                          .order("users.name")
  end
end
