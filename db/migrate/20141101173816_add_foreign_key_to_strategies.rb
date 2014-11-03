class AddForeignKeyToStrategies < ActiveRecord::Migration
  def change
  	add_column :strategies, :user_id, :integer
  end
end
