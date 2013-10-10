class UserActivitiesController < ApplicationController
  def index
    @activity_types = ActivityType.all
    @activities = UserActivity.all_by_date(params[:username], params[:year], params[:month], params[:day])
    @user_exists = User.exists? username: params[:username]
  end

  def all_users_by_date
    @activity_types = ActivityType.all
    @users_activities = UserActivity.all_users_by_date(params[:year], params[:month])
                                                          .joins('LEFT OUTER JOIN users ON users.id = activities.user_id')
                                                          .order("users.name")
  end
end
