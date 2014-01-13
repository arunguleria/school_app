class CreateSubjectsTeachersMaps < ActiveRecord::Migration
  def change
    create_table :subjects_teachers_maps do |t|
      t.integer :subject_id
      t.integer :teacher_id

      t.timestamps
    end
    
    add_index :subjects_teachers_maps, :id
    add_index :subjects_teachers_maps, :teacher_id
    add_index :subjects_teachers_maps, :subject_id
    
  end
end
