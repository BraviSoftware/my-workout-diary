class ActivityTypesController < ApplicationController
  def index
    render json: ActivityType.all, status: :ok
  end
end
