class CreateTerrains < ActiveRecord::Migration[7.2]
  def change
    create_table :terrains do |t|
      t.text :description, null: false

      t.timestamps
    end
    add_index :terrains, :description, unique: true

    create_join_table :planets, :terrains
    add_foreign_key :planets_terrains, :planets
    add_foreign_key :planets_terrains, :terrains
  end
end
