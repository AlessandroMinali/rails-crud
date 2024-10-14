class CreateJoinTablePlanetClimate < ActiveRecord::Migration[7.2]
  def change
    create_join_table :planets, :climates do |t|
      t.index :planet_id
      t.index :climate_id
    end

    create_join_table :planets, :terrains do |t|
      t.index :planet_id
      t.index :terrain_id
    end
  end
end
