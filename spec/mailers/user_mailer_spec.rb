require "spec_helper"

describe UserMailer do
  describe "activity_reminder" do
    let(:mail) { UserMailer.activity_reminder }

    it "renders the headers" do
      mail.subject.should eq("Activity reminder")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
