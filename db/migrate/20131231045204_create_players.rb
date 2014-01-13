class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :club
      t.string :country
      t.string :type

      t.timestamps
    end
    
    add_index :players, :id
    add_index :players, :type
    
  end
end
