class AddDefaults < ActiveRecord::Migration
  def change
  	change_column :users, :admin, :boolean, :default => false
	
	change_column :strategies, :keywords, :string, :default => ""
	change_column :strategies, :department, :string, :default => ""
	change_column :strategies, :subject, :string, :default => ""
  end
end
