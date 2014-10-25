class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.column :email, :string
        t.column :name, :string
        t.column :password_hash, :string
        t.column :admin, :boolean
        t.timestamps
    end
  end
end
