class WorkoutsController < ApplicationController
  def day
    @organization = params[:organization]
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]
  end
end
