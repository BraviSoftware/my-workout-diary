json.array! @activity_types do |activity_type|
  json.(activity_type, :id, :name, :description)
end