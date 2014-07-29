class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.boolean :is_completed, default: false
      t.string :priority
      t.integer :teacher_id

      t.timestamps
    end
    
    add_index :tasks, :id
    add_index :tasks, :teacher_id
    add_index :tasks, :is_completed
    add_index :tasks, :priority
    
  end
end
