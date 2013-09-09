class UserActivity


  def self.all_by_date(username, year, month=nil, day=nil)
    user_id = User.select(:id).find_by(username: username)

    Activity.by_year(year).by_month(month).where(user_id: user_id)
  end

  def self.create(user, params)
    activity_data = { 
      date: params[:date].to_date, 
      activity_type_id: params[:activity_type_id].to_i,
      user_id: user.id 
    }

    unless done_with_this_type_on_this_date?(user, activity_data[:activity_type_id], activity_data[:date])
      activity = Activity.create(activity_data) 
    end
    
    activity
  end

  def self.belongs_to_user?(user, id)
    Activity.exists?(id: id, user_id: user.id)
  end

  def self.done_with_this_type_on_this_date?(user, activity_type_id, date)
    Activity.where(activity_type_id: activity_type_id, user_id: user.id)
    .by_date(date)
    .count > 0
  end

  def self.all_from_yesterday(user)
    Activity.by_yesterday.where(user_id: user.id)
  end

end