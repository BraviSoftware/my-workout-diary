module UserActivitiesHelper
  def activity_title
    "#{Date::MONTHNAMES[request.parameters[:month].to_i]} of #{request.parameters[:year]}"
  end

  def username_title
    request.parameters[:username]
  end

  def group_activities_by_day(activities)
    Hash[(activities.group_by { |g| g.date })]
  end

  def activity_type_bullet(activity_type, activities)
    if activities.any? { |activity| activity.activity_type_id == activity_type.id }
      content_tag( :div, '', :class=>"activity-type-bullet activity-type-bullet-#{activity_type.id}")
    end
  end

  def easter_egg_user_not_found(user_exists)
    image_tag "http://i.qkme.me/3ri3lh.jpg", id: "easter_egg_user_not_found" unless user_exists
  end
end
