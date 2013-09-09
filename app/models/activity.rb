class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_type
  scope :by_date, lambda { |date| where("DATE(date) = ?", date) }
  scope :by_yesterday, -> { Activity.by_date(Date.today.prev_day) }
  scope :by_year, lambda { |year| where("extract(year from date) = ?", year) }
  scope :by_month, lambda { |month| where("extract(month from date) = ?", month) }


  def self.all_by_date(year, month=nil, day=nil)
    date = Date.new(year.to_i, month.to_i, day.to_i)
    
    # find
    includes(:user, :activity_type).by_date(date).order(:id)
  end
end