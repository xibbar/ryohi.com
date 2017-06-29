class CreateDailyAllowances < ActiveRecord::Migration
  def up
    create_table :daily_allowances do |t|
      t.integer :company_id
      t.string :name
      t.integer :one_day_allowance
      t.integer :accommodation_day_allowance
      t.integer :return_day_allowance
      t.integer :position

      t.timestamps
    end
    Employee.all.each do |e|
      if e.company.daily_allowance
        DailyAllowance.create!(name: "#{e.name}の日当", company: e.company, one_day_allowance: e.daily_allowance, accommodation_day_allowance: e.daily_allowance, return_day_allowance: e.daily_allowance)
      else
        DailyAllowance.create!(name: "#{e.name}の日当", company: e.company, one_day_allowance: 0, accommodation_day_allowance: e.daily_allowance, return_day_allowance: e.daily_allowance)
      end
    end
  end
  def down
    drop_table :daily_allowances
  end
end
