require 'spec_helper'

describe UserActivitiesController do
  let(:date) { Time.now.to_date }
  let(:current_user) { FactoryGirl.create(:user) }
  before(:each) { session[:user_id] = current_user.id }

  describe "GET 'index'" do
    def do_get(year, month, day)
      get :index, year: year, month: month, day: day
    end

    it "returns http success" do
      do_get(date.year, date.month, date.day)
      response.should be_success
    end

    it "assigns #activities" do
      do_get(date.year, date.month, date.day)
      assigns(:activities).should_not be_nil
    end
    
    it "assigns #activity_types" do
      do_get(date.year, date.month, date.day)
      assigns(:activity_types).should_not be_nil
    end
  end

end