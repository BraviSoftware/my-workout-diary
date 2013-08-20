require 'spec_helper'

describe WorkoutsController do
  let(:current_user) { FactoryGirl.create(:user) }
  before(:each) { session[:user_id] = current_user.id }
  
  context "GET 'day'" do
    it "returns http success" do
      get :day
      response.should be_success
    end
  end
end
