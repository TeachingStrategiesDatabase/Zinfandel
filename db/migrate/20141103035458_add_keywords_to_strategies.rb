class AddKeywordsToStrategies < ActiveRecord::Migration
  def change
		add_column :strategies, :keywords, :string
  end
end
