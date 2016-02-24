FactoryGirl.define do
  factory :user do
    sequence(:login){|n|"user#{n}"}
    sequence(:email){|n|"user#{n}@example.com"}
    sequence(:name){|n|"User #{n}"}
    state "active"
    prefecture "福島県"
    password "password1234"
  end
  factory :company do
    sequence(:name){|n|"company#{n}"}
    daily_allowance false
    user
  end
  factory :employee do
    sequence(:name){|n|"Employee #{n}"}
    daily_allowance 2000
    accommodation_charges 8000
    company
  end
  factory :schedule do
    days 1
    destination '北都銀行仙台支店'
    business '資金移動'
    date Date.new(2016,1,10)
    employee
  end
  factory :trip_expense do
    section '福島ー仙台'
    way '新幹線'
    round true
    price 8500
    schedule
  end
  factory :expense_template do
    employee
    section '福島ー仙台'
    way '新幹線'
    round true
    price 8500
    schedule
  end
end
