class CreateCitations < ActiveRecord::Migration[6.1]
  def change
    create_table :citations do |t|
      t.text :book, null: false
      t.integer :chapter, null: false
      t.integer :verse, null: false
      t.text :comments
      t.timestamps
    end
    add_index :citations, %i[book chapter verse], unique: true
    add_index :citations, %i[book chapter]
  end
end
