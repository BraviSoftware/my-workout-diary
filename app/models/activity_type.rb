class ActivityType < ActiveRecord::Base
  has_many :activity
  default_scope { where(status: true) }

  IMAGES_PATH = { 
    1 => 'runner.png', 
    2 => 'water.png', 
    3 => 'fruits.png' 
  }

  def image
    "/assets/#{IMAGES_PATH[self.id]}"
  end

  def self.all_not_done_by_user_yesterday(user)
    where.not(id: Activity.all_marked_by_user_yesterday(user).select(:activity_type_id))
  end
end
