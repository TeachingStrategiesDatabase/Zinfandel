class DropKeywordsColumnFromStrategies < ActiveRecord::Migration
  def change
  	remove_column :strategies, :keywords
  end
end
