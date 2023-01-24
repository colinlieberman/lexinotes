class CreateNoteCitations < ActiveRecord::Migration[6.1]
  def change
    create_table :note_citations do |t|
      t.belongs_to :note, null: false, foreign_key: true
      t.belongs_to :citation, null: false, foreign_key: true
      t.timestamps
    end
    add_index :note_citations, %i[note_id citation_id], unique: true
  end
end
