module ApplicationHelper
  def user_activated_email_notification
    if current_user
      if current_user.receive_email_notification
        badge('Activated - Email Notification', :success)
      else
        badge('Deactivated - Email Notification', :important)
      end
    end
  end
end
