class UserActivitiesController < ApplicationController
  def index
    @activity_types = ActivityType.all
    @activities = UserActivity.all_by_date(params[:username], params[:year], params[:month], params[:day])
  end
end
