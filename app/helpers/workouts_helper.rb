module WorkoutsHelper
  def activity_date
    "#{request.parameters[:day]}/#{request.parameters[:month]}/#{request.parameters[:year]}"
  end

  def weekday
    date = selected_date
    date.strftime("%A") if date
  end

  def selected_date
    Date.parse("#{request.parameters[:year]}/#{request.parameters[:month]}/#{request.parameters[:day]}") rescue nil
  end
end
