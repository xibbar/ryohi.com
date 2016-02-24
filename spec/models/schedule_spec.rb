require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe "日帰り日当なしの場合" do
    it "1日" do
      employee = create(:employee, daily_allowance: 1500, accommodation_charges: 5000 )
      schedule = create(:schedule, employee: employee, days: 1)
      expect(schedule.daily_allowance).to eq(0)
      expect(schedule.accommodation_charges).to eq(0)
    end
    it "2日" do
      employee = create(:employee, daily_allowance: 1500, accommodation_charges: 5000 )
      schedule = create(:schedule, employee: employee, days: 2)
      expect(schedule.daily_allowance).to eq(3000)
      expect(schedule.accommodation_charges).to eq(5000)
    end
  end
  describe "日帰り日当なしの場合" do
    it "1日" do
      company = create(:company)
      company.update_attributes(daily_allowance: true)
      employee = create(:employee, company: company, daily_allowance: 1500, accommodation_charges: 5000 )
      schedule = create(:schedule, employee: employee, days: 1)
      expect(schedule.daily_allowance).to eq(1500)
      expect(schedule.accommodation_charges).to eq(0)
    end
    it "2日" do
      company = create(:company)
      company.update_attributes(daily_allowance: true)
      employee = create(:employee, company: company, daily_allowance: 1500, accommodation_charges: 5000 )
      schedule = create(:schedule, employee: employee, days: 2)
      expect(schedule.daily_allowance).to eq(3000)
      expect(schedule.accommodation_charges).to eq(5000)
    end
  end
end
