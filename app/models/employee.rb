class Employee < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :company
  has_many   :target_months, -> { order( [ :year, :month ] ) }
  has_many   :expense_templates, -> { order( :position ) }
  has_many   :schedules, -> { order( date: :desc ) }

  validates :name, presence: true

  def monthly_total(year, month)
    schedules.where("to_char(date, 'yyyy-mm') = ?", Date.new(year,month,1).strftime("%Y-%m")).reorder(date: :asc).to_a.sum{|s|s.total}
  end

end
