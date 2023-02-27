FactoryBot.define do
  factory :daily_allowance do
    #employee_id {1}
    company
    name {"MyString"}
    one_day_allowance {1}
    accommodation_day_allowance {1}
    return_day_allowance {1}
  end
end
