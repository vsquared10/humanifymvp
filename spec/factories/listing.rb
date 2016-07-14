FactoryGirl.define do
  factory :listing do
    description { Faker::Lorem.sentence }
    image { File.new(Rails.root.join('spec', 'support', 'fixtures', 'robohash.png')) }
    title { Faker::Lorem.word }
    visibility { ['global', 'local'].sample }
    points 1
    type { ['ListingAsk', 'ListingOffer', 'ListingCommunity'].sample }
    user

    transient do
      with_highest_offer false
    end

    after(:create) do |l, evaluator|
      if evaluator.with_highest_offer
        create(:offer, status: "pending", listing: l)
      end
    end
  end
end
