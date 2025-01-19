FactoryBot.define do
  factory :user do
    fullname { Faker::Name.name }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.cell_phone }
    password { 'password123' }
    password_confirmation { 'password123' }

    trait :with_avatar do
      after(:build) do |user|
        user.avatar.attach(
          io: Rails.root.join('spec', 'fixtures', 'files', 'avatar.jpg').open,
          filename: 'avatar.jpg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :with_apartments do
      after(:create) do |user|
        create_list(:apartment, 3, user: user)
      end
    end
  end
end
