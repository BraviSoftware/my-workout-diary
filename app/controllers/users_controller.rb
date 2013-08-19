class UsersController < ApplicationController
  before_filter :logged_in?

  def switch_email_notification
    current_user.switch_email_notification
    render json: { receive_email: current_user.receive_email_notification }, status: :ok
  end
end
