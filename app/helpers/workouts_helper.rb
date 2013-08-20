module WorkoutsHelper
  def link_create_activity(activity_type, user_activities)
    images = { 1 => "runner.png", 2 => "water.png", 3 => "fruits.png" }
    params = request.parameters
    data = {
      activity: { 
        date: Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i), 
        activity_type_id: activity_type.id
      }
    }

    user_has_activity = user_activities.any? { |act| act.activity_type_id == activity_type.id }
    css_class =  "btn" << (disabled ? " disabled" : "") 

    # build button
    link_to image_tag(images[activity_type.id]), 
            activities_create_path(data),
            "data-type" => "json", "data-btnajax" => "activity", 
            "data-toggle" => "tooltip", "data-placement" => "bottom",
            remote: true, method: :post, class: css_class, title: activity_type.description
  end

  def activity_date
    "#{request.parameters[:day]}/#{request.parameters[:month]}/#{request.parameters[:year]}"
  end
end
