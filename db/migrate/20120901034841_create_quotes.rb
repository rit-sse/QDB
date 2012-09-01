class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :body
      t.text :description
      t.boolean :approved
      t.boolean :deleted
      t.boolean :flagged

      t.timestamps
    end
  end
end
