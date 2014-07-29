class AddAddressFieldsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :age, :integer, :limit => 3
    add_column :students, :gender, :string
    add_column :students, :salutation, :string
    add_column :students, :address, :string
  end
end
