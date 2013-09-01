json.(@activity, :id)
json.activity_type @activity.activity_type, :id, :name
json.user @activity.user, :id, :name, :username