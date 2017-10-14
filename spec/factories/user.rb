FactoryGirl.define do
  factory :user do
    email    { FFaker::Internet.email }
    nickname { FFaker::Name.unique.name }
    password '111111'
  end
end
