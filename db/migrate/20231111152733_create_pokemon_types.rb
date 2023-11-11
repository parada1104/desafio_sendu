class CreatePokemonTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemon_types do |t|
      t.references :pokemon, null: false, foreign_key: true, index: true
      t.references :typeable, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
