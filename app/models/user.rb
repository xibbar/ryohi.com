class User < ActiveRecord::Base
  include CryptKey
  authenticates_with_sorcery!

  attr_accessor :password_confirmation, :current_password

  has_many :emails, -> { order updated_at: :desc }, dependent: :destroy
  accepts_nested_attributes_for :emails
  has_many :passwords, -> { order updated_at: :desc }, dependent: :destroy
  has_many :companies, -> { order id: :asc }, dependent: :destroy
  has_many :employees, through: :companies
  has_many :target_months, through: :companies
  has_many :schedules, through: :employees
  has_many :expense_templates, through: :employees

  before_create :create_login_key

  validates :login, :name, :email, presence: true
  validates :login, uniqueness: true, format: { with: /\A[a-zA-Z0-9\.\-]+\z/ }, length: { in: 4..40 }, allow_blank: true, allow_nil: true
  validates :email, uniqueness: true
  validates :password, presence: true, length: { in: 8..40 }, allow_nil: true
  validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: :invalid_alnum }, allow_blank: true
  validates :password, format: { with: /[a-z]/, message: :invalid_charactors }, allow_blank: true
  validates :password, format: { with: /[0-9]/, message: :invalid_charactors }, allow_blank: true
  validates :password, confirmation: true
  validates :staff_restrict, presence: true, numericality: true
  validates :prefecture, presence: true

  email_name_regex  = '[\w\.%\+\-]+'.freeze
  domain_head_regex = '(?:[A-Z0-9\-]+\.)+'.freeze
  domain_tld_regex  = '(?:[A-Z]{2,})'.freeze
  email_regex       = /\A#{email_name_regex}@#{domain_head_regex}#{domain_tld_regex}\z/i
  validates_each :email do |record, attr, value|
    record.errors.add(attr, :invalid_email) unless value.blank? || value =~ email_regex
  end

  with_options on: :password do |user|
#    user.validates :password, presence: true, length: { in: 8..40 }, allow_nil: true
#    user.validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: :invalid_alnum }, allow_blank: true
#    user.validates :password, format: { with: /[a-z]/, message: :invalid_charactors }, allow_blank: true
#    user.validates :password, format: { with: /[0-9]/, message: :invalid_charactors }, allow_blank: true
#    user.validates_each :current_password do |record, attr, value|
#      record.errors.add(attr, :mistake) unless record.valid_password?( value )
#    end
  end

#  validates_each :current_password, on: :password do |record, attr, value|
#    record.errors.add(attr, :mistake) unless record.valid_password?( value )
#  end

  validates_each :current_password, on: :email do |record, attr, value|
    record.errors.add(attr, :mistake) unless record.valid_password?( value )
  end

  def active?
    state == "active"
  end

  def staff_restrict_over?
    employees.count >= staff_restrict
  end

  def expires_at_view
    expires_at ? I18n.l( expires_at, format: :long ) : I18n.t('none')
  end

  def expired?( now = Time.zone.now )
    expires_at && expires_at < now.to_date
  end

  def self.search( params_name, order, page = 1 )
    users = User.all
    users = users.order( order ) if order.present?
    users = users.where( [ "name LIKE ?", "%#{ params_name }%" ] ) if params_name.present?

    users.order( id: :desc ).page( page ).per( Setting.per_page )
  end

#  def schedules
#    Schedule.joins(:employee=>{:company=>:user}).where("users.id = ?",self.id)
#  end

  def trip_expenses
    #TripExpense.joins(:schedule=>{:target_month=>{:employee=>{:company=>:user}}}).where("users.id = ?",self.id)
    TripExpense.joins(schedule: [employee: :company]).where(companies: {user_id: self.id})
  end

  private

  def create_login_key
    while login_key.blank? || User.find_by_login_key(login_key)
      self.login_key = crypt_key(login, Time.zone.now.to_s)[0..15]
    end
  end
end
