require 'spec_helper'

describe ActivitiesController do
  before(:each) do
    @date = Time.now.to_date
    @activity_type = FactoryGirl.create(:activity_type)
    @current_user = FactoryGirl.create(:user)
    session[:user_id] = @current_user.id
  end

  context "when POST #create" do    
    def do_create
      post :create, activity: { 
        date: @date,
        activity_type_id: @activity_type.id
      }
    end

    it "creates the activity" do
      do_create
      Activity.count.should eql(1)
    end

    context 'the new activty belongs to ' do
      it "current user" do
        do_create
        Activity.first.user.should eql(@current_user)
      end

      it "activity type" do
        do_create
        Activity.first.activity_type.should eql(@activity_type)
      end
    end

  end

end
