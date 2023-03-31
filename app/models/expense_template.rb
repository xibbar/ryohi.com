class ExpenseTemplate < ActiveRecord::Base
  acts_as_list scope: :company_id, touch_on_update: false

  #belongs_to :employee
  belongs_to :company, required: true

  validates :section, :way, :price, presence: true
  validates :round, inclusion: [true, false]
  validates_each :section do |record, attr, value|
    record.errors.add(:section, :taken) if record.same_check
  end

  def view
    if updated_at >= TaxIncreaseTime
      "#{section} #{way} (#{I18n.t('round.' + round.to_s)}) #{ ActionController::Base.helpers.number_to_currency price }"
    else
      "（！） #{section} #{way} (#{I18n.t('round.' + round.to_s)}) #{ ActionController::Base.helpers.number_to_currency price }"
    end
  end

  def merge( trip_expense )
    self.section = trip_expense.section
    self.round   = trip_expense.round
    self.way     = trip_expense.way
    self.price   = trip_expense.price
    save
  end

  def same_check
    if self.company
      self.company.expense_templates.where.not( id: id ).where( section: section, round: round, way: way, price: price ).any?
    end
  end
end
