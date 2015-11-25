class Password < ActiveRecord::Base
  include CryptKey
  acts_as_paranoid

  belongs_to :user

  before_create :create_reset_key


  private

  def create_reset_key
    while reset_key.blank? || Password.with_deleted.find_by_reset_key(reset_key)
      self.reset_key = crypt_key[0..15]
    end
  end
end
