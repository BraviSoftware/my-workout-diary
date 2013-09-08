class UserActivity


  def self.all_by_date(username, year, month=nil, day=nil)
    user_id = User.select(:id).find_by(username: username)

    Activity.by_year(year).by_month(month).where(user_id: user_id)
  end

end