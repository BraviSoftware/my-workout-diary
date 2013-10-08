class ActivityTypesController < ApplicationController
  def index
    @activity_types = ActivityType.all.order :id
  end
end
