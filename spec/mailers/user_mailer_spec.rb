require "spec_helper"

describe UserMailer do
  describe "activity_reminder" do
    let(:from) { ENV['MWD_MAIL_USERNAME'] }
    let(:user) { FactoryGirl.build :user, email: "to@example.org" }
    let(:mail) { UserMailer.activity_reminder user }

    it "renders the headers" do
      mail.subject.should eq("Activity reminder")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq([from])
    end
  end

end
