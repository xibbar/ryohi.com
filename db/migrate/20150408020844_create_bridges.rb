class CreateBridges < ActiveRecord::Migration
  def change
    create_table :bridges do |t|
      t.integer  :company_id
      t.integer  :position
      t.integer  :target_company_id

      t.timestamps
    end
  end
end
