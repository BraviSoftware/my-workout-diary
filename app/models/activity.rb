class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_type

  def self.all_by_date(year, month=nil, day=nil)
    date = Date.new(year.to_i, month.to_i, day.to_i)
    
    # find
    by_same_date(date)
    .joins(:user, :activity_type)
    .order(:id)
  end

  def self.create_by_user(params, user)
    activity_data = { 
      date: params[:date].to_date, 
      activity_type_id: params[:activity_type_id].to_i,
      user_id: user.id 
    }
    activity = create(activity_data) unless done_by_user_this_type_on_this_date?(user, activity_data[:activity_type_id], activity_data[:date]) 
    activity
  end

  def self.belongs_to_user?(id, user)
    exists?(id: id, user_id: user.id)
  end  

  def self.by_same_date(date)
    where("DATE(date) = ?", date)
  end

  def self.done_by_user_this_type_on_this_date?(user, activity_type_id, date)
    where(activity_type_id: activity_type_id, user_id: user.id)
    .by_same_date(date)
    .count > 0
  end
end