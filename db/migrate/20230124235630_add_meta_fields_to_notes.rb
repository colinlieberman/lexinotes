class AddMetaFieldsToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :notebook_number, :integer
    add_column :notes, :notebook_page, :integer
  end
end
