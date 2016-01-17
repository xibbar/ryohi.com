class Schedule < ActiveRecord::Base
  belongs_to :target_month
  has_many :trip_expenses, -> { order created_at: :asc }, dependent: :destroy

  after_initialize :set_default
  before_validation :create_charges

  validates :target_month_id, :trip_date, :days, :destination, :business, :daily_allowance, :accommodation_charges, presence: true

  def select_view
    "#{trip_date}#{I18n.t('date.day')} : #{destination} : #{business}"
  end

  def date
    start_date = Date.new(target_month.year, target_month.month, trip_date)
    end_date = start_date + (days - 1).days

    if start_date == end_date
      "#{start_date.month}/#{start_date.day}"
    elsif start_date.month == end_date.month
      "#{start_date.month}/#{start_date.day}-#{end_date.day}"
    else
      "#{start_date.month}/#{start_date.day}-#{end_date.month}/#{end_date.day}"
    end
  end
  def total
    daily_allowance + accommodation_charges + trip_expenses.sum(:price)
  end

  private

  def set_default
    self.trip_date = Time.zone.now.day if new_record? && trip_date.blank?
  end

  def create_charges
    if target_month && target_month.employee && ( target_month.employee.company.daily_allowance || days > 1 )
      self.daily_allowance = target_month.employee.daily_allowance * days
      self.accommodation_charges = target_month.employee.accommodation_charges * (days - 1)
    else
      self.daily_allowance = 0
      self.accommodation_charges = 0
    end
  end
end
