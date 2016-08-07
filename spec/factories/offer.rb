FactoryGirl.define do
  factory :offer do
    status 'pending'
    points { rand(10) }
    association :listing, type: 'ListingOffer'
    association :user, strategy: :build
  end
end
