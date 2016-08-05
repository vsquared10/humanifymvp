FactoryGirl.define do
  factory :offer do
    status 'pending'
    points { rand(10) }
  end
end
