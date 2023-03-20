class Company < ActiveRecord::Base
  belongs_to :user, required: true
  has_many   :employees, -> { order id: :asc }, dependent: :destroy
  has_many   :target_months, -> { order year: :desc, month: :desc }, dependent: :destroy
  has_many   :registed_months, -> { group( :year, :month ).order( year: :desc, month: :desc ) }, class_name: "TargetMonth", foreign_key: "company_id"
  has_many   :schedules, -> { order "schedules.trip_date ASC, schedules.days ASC" }, through: :target_months
  has_many   :bridges, -> { order :position }, dependent: :destroy
  has_many   :bridge_companies, -> { order "bridges.position" }, through: :bridges
  has_many   :daily_allowances, -> { order( :position ) }, dependent: :destroy
  has_many   :accommodation_charges, -> { order( :position ) }, dependent: :destroy
  has_many   :expense_templates, -> { order( :position ) }, dependent: :destroy

  validates :name, presence: true
end
