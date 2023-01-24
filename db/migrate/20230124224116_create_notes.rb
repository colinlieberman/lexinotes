class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.timestamp :study_date, null: false
      t.text :content
      t.timestamps
    end
  end
end
