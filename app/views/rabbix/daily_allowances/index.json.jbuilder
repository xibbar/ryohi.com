json.array!(@employee_daily_allowances) do |employee_daily_allowance|
  json.extract! employee_daily_allowance, :id, :employee_id, :name, :one_day_allowance, :accommodation_day_allowance, :return_day_allowance
  json.url employee_daily_allowance_url(employee_daily_allowance, format: :json)
end
