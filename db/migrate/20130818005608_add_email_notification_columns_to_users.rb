class AddEmailNotificationColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_exercise_token, :string
    add_column :users, :receive_email_notification, :boolean
  end
end
