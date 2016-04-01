class Schedule < ActiveRecord::Base
  belongs_to :target_month
  belongs_to :employee
  has_many :trip_expenses, -> { order created_at: :asc }, dependent: :destroy

  before_validation :create_charges#, :set_date

  validates :employee_id, :days, :destination, :business, :daily_allowance, :accommodation_charges, :date, presence: true

  paginates_per 15

  def select_view
    "#{trip_date}#{I18n.t('date.day')} : #{destination} : #{business}"
  end

  def total
    daily_allowance + accommodation_charges + trip_expenses.sum(:price)
  end

  private

  def create_charges
    if employee && !trip_expense_only && ( employee.company.daily_allowance || days > 1 )
      self.daily_allowance = employee.daily_allowance * days
      self.accommodation_charges = employee.accommodation_charges * (days - 1)
    else
      self.daily_allowance = 0
      self.accommodation_charges = 0
    end
  end

   def set_date
#     if date===String
#       date = Date.parse(date)
#       trip_date = date.day
#     end
#   end
     if date && trip_date.blank?
       trip_date = date.day
     end
   end
end
