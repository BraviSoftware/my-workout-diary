class ActivitiesController < ApplicationController
  def index
    activities = Activity.all_by_date(params[:year], params[:month], params[:day])
    render json: activities, status: :ok
  end
  
  def create
    activity = Activity.create_by_user(params[:activity], current_user)
    render json: activity, status: :created
  end

  def destroy
    if Activity.belongs_to_user?(params[:id], current_user)
      Activity.destroy(params[:id])
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :not_found
    end
  end
end