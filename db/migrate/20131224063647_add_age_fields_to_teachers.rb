class AddAgeFieldsToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :age, :integer, :limit => 3
    add_column :teachers, :gender, :string
    add_column :teachers, :salutation, :string
  end
end
