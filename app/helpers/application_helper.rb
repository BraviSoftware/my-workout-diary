module ApplicationHelper
  def user_picture_src(username)
    "https://graph.facebook.com/#{username}/picture?type=small"
  end

  def user_activated_email_notification
    if current_user
      if current_user.receive_email_notification
        content = badge('Activated - Email Notification', :success)
      else
        content = badge('Deactivated - Email Notification', :important)
      end

      link_to content, 
              users_switch_email_notification_path, 
              remote: true, method: :post,
              "data-placement" => 'left',
              "data-toggle" => "tooltip",
              title: "Click to switch it"
    end
  end

  def button_activity_day(opts)
    url = activity_day_url(opts)
    return unless url

    link_to opts[:next] ? "›" : "‹", 
      url,
      class: "#{opts[:next] ? 'right' : 'left'} carousel-control",
      "data-toggle" => "tooltip", 
      "data-placement" => opts[:next] ? 'left' : 'right', 
      "data-bind" => "tooltip: true", 
      "data-original-title" => opts[:next] ? selected_date.next_day : selected_date.prev_day
  end

  private
    def activity_day_url(opts)
      organization = request.parameters[:organization]
      date = selected_date
      return unless organization && date

      date = opts[:next] ? date.next_day : date.prev_day
      return if date > Date.today

      "/#{organization}/#{date.strftime('%Y/%m/%d')}"
    end
end