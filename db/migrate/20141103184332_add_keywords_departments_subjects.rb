class AddKeywordsDepartmentsSubjects < ActiveRecord::Migration
  def change
		create_table :keywords do |t|
			t.string :keyword
			t.integer :strategy_id
		end

		create_table :departments do |t|
			t.string :name
		end

		create_table :subjects do |t|
			t.string :name
		end

		add_column :strategies, :department, :string
		add_column :strategies, :subject, :string
  end
end
