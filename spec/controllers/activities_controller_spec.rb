require 'spec_helper'

describe ActivitiesController do
  let(:date) { Time.now.to_date }
  let(:current_user) { FactoryGirl.create(:user) }
  before(:each) { session[:user_id] = current_user.id }

  describe "when GET #index" do
    def do_get(year, month, day)
      get :index, year: year, month: month, day: day
    end

    it "respond with json" do
      do_get(2013, 8, 12)
      response.content_type.should == Mime::JSON
    end

    it "get all activities by date" do
      year, month, day = '2013', '8', '12'
      Activity.should_receive(:all_by_date).with(year, month, day)
      do_get(year, month, day)
    end
  end

  describe "when POST #create" do    
    let(:activity_type) { FactoryGirl.create(:activity_type) }

    def do_create
      post :create, activity: { 
        date: date,
        activity_type_id: activity_type.id
      }
    end

    it "creates the activity" do
      do_create
      Activity.count.should eql(1)
    end

    context 'the new activty belongs to ' do
      it "current user" do
        do_create
        Activity.first.user.should eql(current_user)
      end

      it "activity type" do
        do_create
        Activity.first.activity_type.should eql(activity_type)
      end
    end
  end

  describe "when DELETE #destroy" do
    let(:activity) { FactoryGirl.create(:activity) }

    def do_destroy(id=nil)
      delete :destroy, id: id 
    end

    it "with existing id deletes the activity" do
      do_destroy(activity.id)
      Activity.exists?(activity.id).should be_false
    end

    it "with no id responds with not found" do
      do_destroy
      response.should be_not_found
    end

    it "with not existing id responds with not found" do
      do_destroy
      response.should be_not_found
    end
  end
end