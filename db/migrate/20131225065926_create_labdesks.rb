class CreateLabdesks < ActiveRecord::Migration
  def change
    create_table :labdesks do |t|
      t.string :lab_number
      t.string :lab_type
      t.integer :student_id

      t.timestamps
    end
    add_index :labdesks, :id
    add_index :labdesks, :lab_number
    add_index :labdesks, :student_id
    add_index :labdesks, :lab_type
 
  end
end
