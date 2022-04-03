class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :profile_photo
      t.string :user_type
      t.string :phone
      t.text :address
      t.date :date_of_birth
      t.datetime :deleted_at
      t.integer :created_user_id
      t.integer :updated_user_id
      t.integer :deleted_user_id

      t.timestamps
    end
  end
end
