# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity_type do
    name "MyString"
    description "MyString"
    status false
  end
end
