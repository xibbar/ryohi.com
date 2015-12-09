class TargetMonth < ActiveRecord::Base
  belongs_to :company
  belongs_to :employee
  has_many   :schedules, -> { order "schedules.trip_date ASC, schedules.days ASC" }, dependent: :destroy
  has_many   :trip_expenses, -> { order "schedules.trip_date ASC, schedules.days ASC, trip_expenses.created_at ASC" }, through: :schedules

  before_validation :insert_employee_name

  validates :company_id, :employee_id, :employee_name, :year, :month, presence: true
  validates_each :month do |record, attr, value|
    record.errors.add( attr, :already_confirmed ) if record.class.where.not( id: record.id ).find_by( employee_id: record.employee_id, year: record.year, month: value )
    record.errors.add( attr, :invalid_select_date ) if Date.new( record.year, value ) > Date.today
  end

  def order_trip_expenses
    schedules.map(&:trip_expenses).flatten
  end

  def date
    I18n.t("target_month.date", year: year, month: month)
  end

  def total_daily_allowance
    schedules.sum(:daily_allowance)
  end

  def total_accommodation_charges
    schedules.sum(:accommodation_charges)
  end

  def schedule_total
    total_daily_allowance + total_accommodation_charges
  end

  def trip_expense_total
    trip_expenses.sum(:price)
  end

  def total
    schedule_total + trip_expense_total
  end

  def employees
    self.class.where( company_id: company_id, year: year, month: month ).order( :employee_id )
  end

  def employee_months
    self.class.where( company_id: company_id, employee_id: employee_id ).order( :year, :month )
  end

  def employee_next_target_month
    time = Time.mktime(year, month).next_month
    self.class.where(employee_id: employee_id).where(year: time.year).where(month: time.month).first
  end

  def employee_previous_target_month
    time = Time.mktime(year, month).last_month
    self.class.where(employee_id: employee_id).where(year: time.year).where(month: time.month).first
  end

  private

  def insert_employee_name
    self.employee_name = employee.name if employee
  end
end
