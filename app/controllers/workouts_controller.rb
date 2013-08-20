class WorkoutsController < ApplicationController
  def day
    @organization = params[:organization]
    @date = {
      year: params[:year],
      month: params[:month],
      day: params[:day]
    }

    @activity_types = ActivityType.all

    @user_activities = Activity.where user_id: current_user.id
  end
end
