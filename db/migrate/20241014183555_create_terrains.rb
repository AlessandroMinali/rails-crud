class CreateTerrains < ActiveRecord::Migration[7.2]
  def change
    create_table :terrains do |t|
      t.text :description

      t.timestamps
    end
    add_index :terrains, :description, unique: true
  end
end
