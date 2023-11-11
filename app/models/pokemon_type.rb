class PokemonType < ApplicationRecord
  belongs_to :pokemon
  belongs_to :typeable
end
