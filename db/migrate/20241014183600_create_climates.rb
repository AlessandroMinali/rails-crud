class CreateClimates < ActiveRecord::Migration[7.2]
  def change
    create_table :climates do |t|
      t.text :description

      t.timestamps
    end
    add_index :climates, :description, unique: true
  end
end
