FactoryBot.define do
  factory :user do
    sequence(:login){|n|"user#{n}"}
    sequence(:email){|n|"user#{n}@example.com"}
    sequence(:name){|n|"User #{n}"}
    state {"active"}
    prefecture {"福島県"}
    password {"password1234"}
  end
  factory :company do
    sequence(:name){|n|"company#{n}"}
    #daily_allowance {false}
    user
  end
  factory :employee do
    sequence(:name){|n|"Employee #{n}"}
    #daily_allowance {2000}
    #accommodation_charges {8000}
    company
  end
  factory :schedule do
    days {1}
    destination {'北都銀行仙台支店'}
    business {'資金移動'}
    date {Date.new(2023,1,10)}
    employee
    daily_allowance
    accommodation_charge
  end
  factory :trip_expense do
    sequence(:section){|n| "福島ー仙台#{n}"}
    way {'新幹線'}
    round {true}
    price {8500}
    schedule
  end
  factory :expense_template do
    employee
    sequence(:section) {|n| "福島ー東京#{n}"}
    way {'新幹線'}
    round {true}
    price {8500}
    #schedule
  end
end
