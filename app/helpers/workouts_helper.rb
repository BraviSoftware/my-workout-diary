module WorkoutsHelper
  def activity_date
    "#{request.parameters[:day]}/#{request.parameters[:month]}/#{request.parameters[:year]}"
  end
end
