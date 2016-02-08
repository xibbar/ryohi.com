class AddDateToSchedules < ActiveRecord::Migration
  def up
    add_column :schedules, :date, :date
    add_column :schedules, :employee_id, :integer
    Schedule.all.each do |schedule|
      target_month = TargetMonth.find(schedule.target_month_id)
      schedule.date = Date.new(target_month.year, target_month.month, schedule.trip_date)
      schedule.employee_id = Employee.find(target_month.employee_id).id
      schedule.save
    end
  end
  def down
    remove_column :schedules, :date
    remove_column :schedules, :employee_id
  end
end
