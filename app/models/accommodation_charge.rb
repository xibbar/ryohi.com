class AccommodationCharge < ActiveRecord::Base
  belongs_to :company, required: true
  validates :name, :amount, presence: true
  acts_as_list scope: :company_id
end
