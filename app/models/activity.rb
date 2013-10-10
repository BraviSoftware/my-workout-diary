class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_type
  scope :by_date, lambda { |date| where("DATE(date) = ?", date) }
  scope :by_yesterday, -> { Activity.by_date(Date.today.prev_day) }
  scope :by_year, lambda { |year| where("extract(year from date) = ?", year.to_i) }
  scope :by_month, lambda { |month| where("extract(month from date) = ?", month.to_i) }


  def self.all_by_date(year, month=nil, day=nil)
    date = Date.new(year.to_i, month.to_i, day.to_i)
    
    # find
    includes(:user, :activity_type).by_date(date).order(:id)
  end

  def self.by_activity_type_group_by_user_name(activity_type)
    where(activity_type_id: activity_type.id).group("users.name")
  end
end