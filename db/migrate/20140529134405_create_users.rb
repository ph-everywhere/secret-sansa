class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :initials
      t.boolean :disabled

      t.timestamps
    end
  end
end