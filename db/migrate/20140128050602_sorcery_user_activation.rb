class SorceryUserActivation < ActiveRecord::Migration
  def self.up
    add_column :companies, :state, :string, :default => nil
    add_column :companies, :activation_token, :string, :default => nil
    add_column :companies, :activation_token_expires_at, :datetime, :default => nil
    
    add_index :companies, :activation_token
  end

  def self.down
    remove_index :companies, :activation_token
    
    remove_column :companies, :activation_token_expires_at
    remove_column :companies, :activation_token
    remove_column :companies, :state
  end
end
