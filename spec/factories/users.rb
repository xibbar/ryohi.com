FactoryGirl.define do
  factory :user do
    sequence(:login){|n|"user#{n}"}
    sequence(:email){|n|"user#{n}@example.com"}
    sequence(:name){|n|"User #{n}"}
    state "active"
    prefecture "福島県"
    password "password1234"
  end
end
