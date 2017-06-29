class Schedule < ActiveRecord::Base
  belongs_to :target_month
  belongs_to :employee
  belongs_to :daily_allowance
  belongs_to :accommodation_charge
  has_many :trip_expenses, -> { order created_at: :asc }, dependent: :destroy

  before_validation :create_charges#, :set_date

  validates :employee_id, :days, :destination, :business, :daily_allowance_amount, :accommodation_charge_amount, :date, presence: true

  paginates_per 15

  def select_view
    "#{trip_date}#{I18n.t('date.day')} : #{destination} : #{business}"
  end

  def total
    daily_allowance_amount + accommodation_charge_amount + trip_expenses.sum(:price)
  end

  private

  # test required
  def create_charges
    if days == 1
      self.daily_allowance_amount = self.daily_allowance.one_day_allowance
      self.accommodation_charge_amount = self.accommodation_charge.amount
    elsif days > 1
      self.daily_allowance_amount =
        self.daily_allowance.accommodation_day_allowance * (days-1) +
        self.daily_allowance.return_day_allowance
      self.accommodation_charge_amount = self.accommodation_charge.amount * (days - 1)
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
