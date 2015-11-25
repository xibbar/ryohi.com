class Bridge < ActiveRecord::Base
  acts_as_list scope: :company_id

  attr_accessor :login, :password

  belongs_to :company
  belongs_to :bridge_company, class_name: 'Company', foreign_key: :target_company_id

#  validates :company_id, :target_company_id, presence: true
  validates_each :target_company_id do |record, attr, value|
    if record.company.bridge_companies.find_by( login: record.login )
      record.errors.add( :login, :already_confirmed )
    end
  end

  with_options on: :check_password do |bridge|
    bridge.validates :login, presence: true
    bridge.validates :password, presence: true
    bridge.validates_each :password do |record, attr, value|
      if value.present?
        record.errors.add( attr, :mistake ) unless Company.authenticate( record.login, value )
      end
    end
  end

  def both_save
    target = Company.find_by( login: login )
    self.target_company_id = target.id
    save
    someone = self.class.create( company_id: target_company_id, target_company_id: company_id )
  end

  def both_destroy
    someone = self.class.find_by( company_id: target_company_id, target_company_id: company_id )
    someone.destroy
    destroy
  end
end
