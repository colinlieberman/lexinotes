class RemoveBadRestrictions < ActiveRecord::Migration[6.1]
  def change
    remove_index :citations, %i[book chapter verse], unique: true

    add_index :citations, %i[book chapter verse]
  end
end
