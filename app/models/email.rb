class Email < ActiveRecord::Base
  include CryptKey
  acts_as_paranoid

  belongs_to :user

  before_save :create_activate_key

  validates :email, :company_id, presence: true
  email_name_regex  = '[\w\.%\+\-]+'.freeze
  domain_head_regex = '(?:[A-Z0-9\-]+\.)+'.freeze
  domain_tld_regex  = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'.freeze
  email_regex       = /\A#{email_name_regex}@#{domain_head_regex}#{domain_tld_regex}\z/i
  validates_each :email do |record, attr, value|
    record.errors.add(attr, :invalid_email) unless value.blank? || value =~ email_regex
    # 他のアカウントのメールアドレスと変更中のアドレスにも使われて居ないか確認する。
    if record.company && (value == record.company.email || User.where(["email = ? AND id != ?", value, record.company.id]).any? || record.class.where(["email = ? AND company_id != ?", value, record.company.id]).any?)
      record.errors.add(attr, :already_used)
    end
  end

  private

  def create_activate_key
    while activate_key.blank? || Email.with_deleted.find_by_activate_key(activate_key)
      self.activate_key = crypt_key[0..15]
    end
  end
end
