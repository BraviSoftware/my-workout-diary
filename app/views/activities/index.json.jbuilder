json.array! @activities do |activity|
  json.(activity, :id)
  json.activity_type activity.activity_type, :id, :name
  json.user activity.user, :id, :uid, :name, :username, :provider
end