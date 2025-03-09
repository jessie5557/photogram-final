class RenameOldColumnNameToNewColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :follow_requests, :recipeint_id, :recipient_id
    
  end
end
