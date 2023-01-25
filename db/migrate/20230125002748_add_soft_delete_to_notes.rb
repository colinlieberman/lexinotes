class AddSoftDeleteToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :active, :boolean, null: false, default: true
  end
end
