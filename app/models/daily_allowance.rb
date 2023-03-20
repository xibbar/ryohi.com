class DailyAllowance < ActiveRecord::Base
  belongs_to :company
  validates :name, :one_day_allowance, :accommodation_day_allowance, :return_day_allowance, presence: true
  acts_as_list scope: :company_id
end
