class ActivitiesController < ApplicationController
  def index
    activities = Activity.all_by_date(params[:year], params[:month], params[:day])
    render json: activities, status: :success
  end

  def create
    activity = Activity.switch_activity_by_user(activity_params, current_user)
    if activity
      render json: activity, status: :created
    else
      render nothing: true, status: :ok
    end
  end

  def destroy
    if Activity.belongs_to_user?(params[:id], current_user)
      Activity.destroy(params[:id])
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :not_found
    end
  end

  private
    def activity_params
      params.require(:activity).permit(:date, :activity_type_id)
    end
end