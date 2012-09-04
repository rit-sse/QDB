class RemoveDeletedFromQuote < ActiveRecord::Migration
  def up
    remove_column :quotes, :deleted
  end

  def down
    add_column :quotes, :deleted, :boolean
  end
end
