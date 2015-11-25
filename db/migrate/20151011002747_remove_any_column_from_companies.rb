class RemoveAnyColumnFromCompanies < ActiveRecord::Migration
  def up
    remove_column :companies, :login_key
    remove_column :companies, :reset_password_email_sent_at
    remove_column :companies, :reset_password_token_expires_at
    remove_column :companies, :reset_password_token
    remove_column :companies, :activation_token_expires_at
    remove_column :companies, :activation_token
    remove_column :companies, :state
    remove_column :companies, :salt
    remove_column :companies, :crypted_password
    remove_column :companies, :email
    remove_column :companies, :login
  end

  def down
    add_column :companies, :login,                           :string
    add_column :companies, :email,                           :string,    default: nil
    add_column :companies, :crypted_password,                :string,    default: nil
    add_column :companies, :salt,                            :string,    default: nil
    add_column :companies, :state,                           :string,    default: nil
    add_column :companies, :activation_token,                :string,    default: nil
    add_column :companies, :activation_token_expires_at,     :timestamp, default: nil
    add_column :companies, :reset_password_token,            :string,    default: nil
    add_column :companies, :reset_password_token_expires_at, :timestamp, default: nil
    add_column :companies, :reset_password_email_sent_at,    :timestamp, default: nil
    add_column :companies, :login_key,                       :string
  end
end
