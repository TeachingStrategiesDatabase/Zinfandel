class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
        t.column :title, :string
        t.column :body, :text
        t.column :tech, :string
        t.column :source, :string

        t.timestamps
    end
  end
end
