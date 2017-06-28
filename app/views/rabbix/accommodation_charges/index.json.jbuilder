json.array!(@accommodation_charges) do |accommodation_charge|
  json.extract! accommodation_charge, :id, :company_id, :name, :amount
  json.url accommodation_charge_url(accommodation_charge, format: :json)
end
