json.array! @activities do |activity|
  json.(activity, :id)
  json.activity_type activity.activity_type, :id, :name
  json.user activity.user, :id, :uid, :oauth_token, :picture, :name, :username, :provider
end