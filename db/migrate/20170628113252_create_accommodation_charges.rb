class CreateAccommodationCharges < ActiveRecord::Migration
  def up
    create_table :accommodation_charges do |t|
      t.integer :company_id
      t.string :name
      t.integer :amount
      t.integer :position

      t.timestamps
    end
    Employee.all.each do |e|
      AccommodationCharge.create!(name: "#{e.name}の宿泊費", company: e.company, amount: e.accommodation_charges)
    end
  end
  def down
    drop_table :accommodation_charges
  end
end
