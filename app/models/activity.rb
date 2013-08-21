class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_type

  def self.all_by_date(year, month=nil, day=nil)
    date = Date.new(year.to_i, month.to_i, day.to_i)
    
    # find
    where("DATE(date) = ?", date)
    .joins(:user, :activity_type)
    .order(:id)
  end

  def self.create_by_user(params, user)
    activity = Activity.new(
      date: Date.parse(params[:date]),
      activity_type_id: params[:activity_type_id].to_i
      )
    activity.user = user
    activity.save
  end

  def self.belongs_to_user?(id, user)
    !id.nil? and find_by_id_and_user_id(id, user.id).nil?
  end    
end
