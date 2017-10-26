class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      #timestamps creates two columns:
      #created_at and updated_at
      t.timestamps
    end
  end
end
