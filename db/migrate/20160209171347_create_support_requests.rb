class CreateSupportRequests < ActiveRecord::Migration
  def change
    create_table :support_requests do |t|
      t.string :name
      t.string :email
      t.integer :department, default: 0
      t.text :message
      t.boolean :complete, null: false, default: false

      t.timestamps null: false
    end
  end
end
