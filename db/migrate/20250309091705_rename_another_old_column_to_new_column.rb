class RenameAnotherOldColumnToNewColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :photos, :capation, :caption
  end
end
