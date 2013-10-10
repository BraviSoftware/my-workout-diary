MyWorkoutDiary::Application.routes.draw do
  root to: redirect("/bravi-software/#{Time.now.strftime('%Y/%m/%d')}")

  # Workouts
  match ':organization/:year/:month/:day', 
    to: 'workouts#day', as: 'day', via: [:get],
    defaults: { 
      organization: 'bravi-software', 
      year: Date.today.year, 
      month: "%02d" % Date.today.month, 
      day: "%02d" % Date.today.day 
    }, 
    constraints: {
      organization: 'bravi-software',
      month: /\d{2}/, 
      day: /\d{2}/ 
    }
  
  # Activity Types
  match "activity_types", to: "activity_types#index", via:[:get]
  
  # Activities
  resources :activities, only: [:index, :create, :destroy]
  get "activities/mark_yesterday_by_token/:token", to: "activities#mark_yesterday_by_token", as: 'mark_yesterday_by_token'
  
  # User Activities
  get "users/:username/activities/:year/:month", to: "user_activities#index", as: "user_activities"
  get "users/activities/:year/:month", to: "user_activities#all_users_by_date", as: "all_users_by_date"
  get "users/activities/charts/:year/:month", to: "user_activities#all_users_by_date_charts", as: "all_users_by_date_charts"

  # Users
  match "users/switch_email_notification", via: [:post]

  # Auth
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
