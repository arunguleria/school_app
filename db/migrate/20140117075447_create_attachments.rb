class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.attachment :asset

      t.timestamps
    end
    
    add_index :attachments, :id
    add_index :attachments, [:attachable_id, :attachable_type]
    
  end
end
