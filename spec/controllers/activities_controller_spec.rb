require 'spec_helper'

describe ActivitiesController do
  let(:date) { Time.now.to_date }
  let(:current_user) { FactoryGirl.create(:user) }
  before(:each) { session[:user_id] = current_user.id }

  describe "when GET #index" do
    def do_get(year, month, day)
      get :index, year: year, month: month, day: day, format: :json
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

    context "when a user has not done activity yet" do
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

    context "when a user has done activity already" do
      before(:each) { FactoryGirl.create(:activity, date: date, activity_type_id:  activity_type.id, user_id: current_user.id) }

      it "not creates the activity" do
        expect{
          do_create
        }.not_to change(Activity, :count)
      end

      it "responds with unprocessable" do
        do_create
        response.should be_unprocessable
      end
    end
  end

  describe "when DELETE #destroy" do
    # forces generate now
    let!(:activity) { FactoryGirl.create(:activity, user_id: current_user.id) }

    def do_destroy(id=nil)
      delete :destroy, id: id 
    end

    it "with existing id deletes the activity" do
      expect{
        do_destroy(activity.id)
        }.to change(Activity, :count).by(-1)
    end

    it "with no id responds with not found" do
      do_destroy
      response.should be_bad_request
    end

    it "with not existing id responds with not found" do
      do_destroy
      response.should be_bad_request
    end
  end

  describe "when POST #mark_yesterday_by_token" do
    let(:activity_type) { FactoryGirl.create(:activity_type) }
    before(:each) { current_user.generate_email_notification_token }

    
    def do_remote_mark(token)
      get :mark_yesterday_by_token, token: token
    end

    context "with valid token" do
      let(:valid_token) { current_user.email_activity_token_by_activity_type(activity_type) }
      it "responds with ok" do
        do_remote_mark(valid_token)
        response.should be_redirect
      end

      it "marks activity" do
        expect{
          do_remote_mark(valid_token)
          }.to change(Activity, :count).by(1)
      end
    end

    context "with invalid token" do
      let(:invalid_token) { "987asd8f7as9df89asd987fs" }
      it "responds with unprocessable" do
        do_remote_mark(invalid_token)
        response.should be_unprocessable
      end

      it "doesn't mark activity" do
        expect{
          do_remote_mark(invalid_token)
          }.to change(Activity, :count).by(0)
      end
    end
  end
end