class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all_by_date(params[:year], params[:month], params[:day])
  end
  
  def create
    @activity = Activity.create_by_user(params[:activity], current_user)
    if @activity.present?
      render 'create.json.jbuilder', status: :created
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def destroy
    if Activity.belongs_to_user?(params[:id], current_user)
      Activity.destroy(params[:id])
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :bad_request
    end
  end
end