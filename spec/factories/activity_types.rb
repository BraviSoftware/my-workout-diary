# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity_type do
    name "Activity"
    description "Description..."
    status true
  end
end
