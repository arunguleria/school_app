class CreateLockers < ActiveRecord::Migration
  def change
    create_table :lockers do |t|
      t.string :locker_number
      t.string :compartment
      t.integer :teacher_id

      t.timestamps
    end
    
    add_index :lockers, :id
    add_index :lockers, :locker_number
    add_index :lockers, :teacher_id
    add_index :lockers, :compartment
    
  end
end
