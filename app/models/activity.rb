class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_type

  def self.create_with_user(params, user)
    activity = Activity.new(
      date: Date.parse(params[:date]),
      activity_type_id: params[:activity_type_id].to_i
    )
    activity.user = user
    activity.save
  end
end
