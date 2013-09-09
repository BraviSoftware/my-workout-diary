class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all_by_date(params[:year], params[:month], params[:day])
  end
  
  def create
    @activity = UserActivity.create(current_user, params[:activity])
    if @activity.present?
      render 'create.json.jbuilder', status: :created
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def destroy
    if UserActivity.belongs_to_user?(current_user, params[:id])
      Activity.destroy(params[:id])
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :bad_request
    end
  end

  def mark_yesterday_by_token
    if ActivityReminder.mark_by_token(params[:token])
      flash[:notice] = "Successfully marked activity." 
      redirect_to ("/bravi-software/#{Date.today.prev_day.strftime('%Y/%m/%d')}")
    else
      render nothing: true, status: :unprocessable_entity
    end
  end
end