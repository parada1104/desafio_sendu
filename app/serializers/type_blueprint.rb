# frozen_string_literal: true

class TypeBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  view :with_pokemons do
    association :pokemons, blueprint: PokemonBlueprint
  end

  view :only_name do
    exclude :id
  end
end
