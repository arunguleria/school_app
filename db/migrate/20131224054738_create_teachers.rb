class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps # created_at and updated_at
    end
    
    add_index :teachers, :id
    add_index :teachers, :email
    
  end
end
