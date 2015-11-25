class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer  :company_id
      t.string   :activate_key
      t.string   :email
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
