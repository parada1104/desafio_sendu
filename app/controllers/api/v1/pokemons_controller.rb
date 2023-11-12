# frozen_string_literal: true

module Api
  module V1
    class PokemonsController < V1Controller
      before_action :set_pokemon, except: %i[index create]

      def index
        @pokemons = Pokemon.search_results(params)
        json_response(@pokemons, :ok)
      end

      def show
        json_response(PokemonBlueprint.render(@pokemon))
      end

      def create
        @pokemon = Pokemon.new(pokemon_params)
        @pokemon.save!
        json_response(PokemonBlueprint.render(@pokemon), :created)
      end

      def update
        @pokemon.update!(pokemon_params)
        json_response(PokemonBlueprint.render(@pokemon), :ok)
      end

      def destroy
        @pokemon.destroy!
        json_response({ message: 'Pokemon deleted' }, :ok)
      end

      private

      def set_pokemon
        @pokemon = Pokemon.find(params[:id])
      end

      def pokemon_params
        params.require(:pokemon)
              .permit(:name,
                      :height,
                      :weight,
                      :order,
                      :base_experience,
                      type_ids: [])
      end
    end
  end
end
