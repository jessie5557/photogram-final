class ChangeColumnTypeInTableName < ActiveRecord::Migration[7.1]
  def change
    change_column :photos, :caption, :text
  end
end
