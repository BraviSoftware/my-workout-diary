json.array! @activities do |activity|
  json.(activity, :id, :activity_type_id)
  json.user activity.user, :id, :name, :username
end