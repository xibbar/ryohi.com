class Employee < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :company
  has_many   :target_months, -> { order( [ :year, :month ] ) }
  has_many   :expense_templates, -> { order( :position ) }
  has_many   :schedules, -> { order( date: :desc ) }

  validates :name, :daily_allowance, :accommodation_charges, presence: true
  validates :daily_allowance, :accommodation_charges, numericality: true
end
