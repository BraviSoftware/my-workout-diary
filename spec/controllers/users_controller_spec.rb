require 'spec_helper'

describe UsersController do
  let(:current_user) { FactoryGirl.create(:user) }
  before(:each) { session[:user_id] = current_user.id }

  describe "when POST #switch_email_notification" do    

    def do_switch_email_notification(activating)
      # change current user to oposite value before post action
      current_user.update_attribute :receive_email_notification, !activating

      post :switch_email_notification
    end

    context "when activating" do
      it "switch email notification to activated" do
        do_switch_email_notification true
        User.find(current_user.id).receive_email_notification.should be_true
      end
    end

    context "when deactivating" do
      it "switch email notification to deactivated" do
        do_switch_email_notification false
        User.find(current_user.id).receive_email_notification.should be_false
      end
    end
  end
end