class TripExpense < ActiveRecord::Base
  belongs_to :schedule

  validates :schedule_id, :section, :way, :price, presence: true
  validates :round, inclusion: [true, false]

  def date
    schedule.date
  end

  def section_view
    section + (round ? '（往復）' : '')
  end

  def add_template( target_month )
    expense_template = target_month.employee.expense_templates.build
    expense_template.merge( self )
  end
end
