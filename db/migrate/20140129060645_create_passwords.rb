class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.integer  :company_id
      t.string   :reset_key
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
