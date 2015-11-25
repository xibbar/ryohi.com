class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :login,                           null: false  # if you use another field as a username, for example email, you can safely remove this field.
      t.string    :email,                           default: nil # if you use this field as a username, you might want to make it :null => false.
      t.string    :crypted_password,                default: nil
      t.string    :salt,                            default: nil
      t.string    :name
      t.string    :state,                           default: nil
      t.string    :activation_token,                default: nil
      t.timestamp :activation_token_expires_at,     default: nil
      t.string    :reset_password_token,            default: nil
      t.timestamp :reset_password_token_expires_at, default: nil
      t.timestamp :reset_password_email_sent_at,    default: nil
      t.string    :login_key

      t.timestamps
    end

    add_index :users, :activation_token
    add_index :users, :reset_password_token
  end
end
