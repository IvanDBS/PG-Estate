FactoryBot.define do
  factory :apartment do
    bedroom { ['1', '2', '3', '4+'].sample }
    apt_type { Apartment.apt_types.keys.sample }
    condition { Apartment.conditions.keys.sample }
    price { Faker::Number.between(from: 50_000, to: 1_000_000) }
    location { Faker::Address.full_address }
    user

    trait :with_pictures do
      after(:build) do |apartment|
        2.times do |i|
          apartment.pictures.attach(
            io: Rails.root.join('spec', 'fixtures', 'files', "apartment#{i + 1}.jpg").open,
            filename: "apartment#{i + 1}.jpg",
            content_type: 'image/jpeg'
          )
        end
      end
    end
  end
end
