class ActivitiesController < ApplicationController
  def create
    Activity.create_with_user(params[:activity], current_user)
  end
end
