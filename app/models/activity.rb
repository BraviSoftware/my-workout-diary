class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_type
  scope :by_yesterday, -> { where("DATE(date) = ?", Date.today.prev_day) }
  scope :by_year, lambda { |year| where("extract(year from date) = ?", year) }
  scope :by_month, lambda { |month| where("extract(month from date) = ?", month) }


  def self.all_by_date(year, month=nil, day=nil)
    date = Date.new(year.to_i, month.to_i, day.to_i)
    
    # find
    includes(:user, :activity_type).by_date(date).order(:id)
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
  
  def self.mark_by_token(params)
    raw_token = params.split("_")
    return false unless raw_token.size == 3

    date = raw_token[0]
    token = raw_token[1]
    activity_type_id = raw_token[2]

    return  false unless valid_token?(date, token, activity_type_id)

    user = User.find_by(email_exercise_token: token)
    yesterday = Date.today.prev_day

    # already was marked by user
    return false if Activity.done_by_user_this_type_on_this_date?(user, activity_type_id, yesterday)

    activity = create_by_user({ date: yesterday, activity_type_id: activity_type_id}, user)
    if activity
      user.clear_email_notification_token
    end
    activity
  end

  def self.valid_token?(date, token, activity_type_id)
    return false unless date == Date.today.prev_day.to_s
    return false unless ActivityType.exists?(id: activity_type_id)
    return false unless User.exists?(email_exercise_token: token)
    true
  end

  def self.belongs_to_user?(id, user)
    exists?(id: id, user_id: user.id)
  end  

  def self.by_date(date)
    where("DATE(date) = ?", date)
  end

  def self.done_by_user_this_type_on_this_date?(user, activity_type_id, date)
    where(activity_type_id: activity_type_id, user_id: user.id)
    .by_date(date)
    .count > 0
  end

  def self.all_marked_by_user_yesterday(user)
    by_yesterday.where(user_id: user.id)
  end
end