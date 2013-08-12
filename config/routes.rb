MyWorkoutDiary::Application.routes.draw do
  root to: redirect("/bravi-software/#{Time.now.strftime('%Y/%m/%d')}")

  # Workouts
  match ':organization/:year/:month/:day', to: 'workouts#day', as: 'day', via: [:get]
  
  # Activities
  match "activities/create", via: [:post]
  match "activities/destroy", via: [:delete]
  
  # Auth
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
