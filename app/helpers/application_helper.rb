module ApplicationHelper
  def user_activated_email_notification
    if current_user
      if current_user.receive_email_notification
        content = badge('Activated - Email Notification', :success)
      else
        content = badge('Deactivated - Email Notification', :important)
      end

      link_to content, users_switch_email_notification_path, remote: true, method: :post
    end
  end
end
