require 'spec_helper'

describe WorkoutsController do
  context "GET 'day'" do
    it "returns http success" do
      get :day
      response.should be_success
    end
  end
end
