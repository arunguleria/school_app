class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    
    add_index :subjects, :id
    add_index :subjects, :name
    
  end
end
