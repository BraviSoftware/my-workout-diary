MyWorkoutDiary::Application.routes.draw do
  get "workouts/day"
  root "workouts#day"
end
