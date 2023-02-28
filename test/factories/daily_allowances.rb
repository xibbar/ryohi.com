FactoryBot.define do
  factory :daily_allowance do
    #employee_id {1}
    company
    name {"日当"}
    one_day_allowance {1000}
    accommodation_day_allowance {2000}
    return_day_allowance {3000}
  end
end
