MyWorkoutDiary::Application.routes.draw do
  root to: redirect("/bravi-software/#{Time.now.strftime('%Y/%m/%d')}")

  # Workouts
  match ':organization/:year/:month/:day', to: 'workouts#day', as: 'day', via: [:get]
  
  # Activity Types
  match "activity_types", to: "activity_types#index", via:[:get]
  
  # Activities
  resources :activities, only: [:index, :create, :destroy]
  post "activities/mark_yesterday_by_token/:token", to: "activities#mark_yesterday_by_token", as: 'mark_yesterday_by_token'
  
  # Users
  match "users/switch_email_notification", via: [:post]

  # Auth
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
