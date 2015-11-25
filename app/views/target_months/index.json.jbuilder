json.array!(@target_months) do |target_month|
  json.extract! target_month, :id, :company_id, :year, :month, :staff_name, :index, :new, :edit, :create, :update, :destroy
  json.url target_month_url(target_month, format: :json)
end
