class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :filename
      t.text :descirption
      t.string :file_type
      t.string :photographable_type
      t.integer :photographable_id

      t.timestamps
    end
    
    add_index :photos, :id
    add_index :photos, [:photographable_type, :photographable_id]
    
  end
end
