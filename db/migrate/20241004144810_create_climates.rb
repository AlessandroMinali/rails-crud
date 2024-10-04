class CreateClimates < ActiveRecord::Migration[7.2]
  def change
    create_table :climates do |t|
      t.text :description, null: false

      t.timestamps
    end
    add_index :climates, :description, unique: true

    create_join_table :planets, :climates
    add_foreign_key :climates_planets, :planets
    add_foreign_key :climates_planets, :climates
  end
end
