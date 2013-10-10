module UserActivitiesHelper
  def activity_title
    "#{Date::MONTHNAMES[request.parameters[:month].to_i]} of #{request.parameters[:year]}"
  end

  def username_title
    request.parameters[:username]
  end

  def link_to_day(day, month=nil, year=nil)
    year = year || request.parameters[:year].to_i
    month = month || request.parameters[:month].to_i

    # build link
    link_to "%02d" % day, 
                day_path(year: year, month: "%02d" % month, day: "%02d" % day), 
                "data-bind" => "tooltip: true", 
                "data-toggle"=> "tooltip",
                "data-original-title" => "Move to this date to manage your activities"
  end

  def group_activities_by_day(activities)
    Hash[(activities.group_by { |g| g.date })]
  end

  def group_activities_by_user(activities)
    Hash[(activities.group_by { |g| g.user })]
  end

  def activity_type_bullet(activity_type, activities)
    icon_type_bullet(activity_type) if activities.any? { |activity| activity.activity_type_id == activity_type.id }
  end

  def activity_type_bullet_by_date(activity_type, activities, date)
    icon_type_bullet(activity_type) if activities.any? { |activity| activity.activity_type_id == activity_type.id && activity.date.day == date }
  end

  def easter_egg_user_not_found(user_exists)
    image_tag "http://i.qkme.me/3ri3lh.jpg", id: "easter_egg_user_not_found" unless user_exists
  end

  def list_days_in_month
    (1..Time.days_in_month(request.parameters[:month].to_i, request.parameters[:year].to_i))
  end

  private
  def icon_type_bullet(activity_type)
    content_tag :div, '', 
                          :class=>"activity-type-bullet activity-type-bullet-#{activity_type.id}", 
                          "data-toggle"=> "tooltip",
                          title: activity_type.name
  end
end
