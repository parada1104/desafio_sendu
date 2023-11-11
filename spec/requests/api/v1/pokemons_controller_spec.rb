# frozen_string_literal: true

RSpec.describe 'Api::V1::Pokemons', type: :request do
  # Todo test index with params to map with scopes
  describe 'index' do
    describe 'HTTP request' do
      before do
        create_list(:pokemon, 10)
      end

      it 'returns a successful response' do
        get api_v1_pokemons_path
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(json_response.size).to eq(10)
        expect(json_response[0]).to include('name', 'order', 'base_experience', 'height', 'weight')
      end
    end
  end

  describe 'show' do
    describe 'HTTP request' do
      let(:pokemon) { create(:pokemon) }

      it 'returns a successful response' do
        get api_v1_pokemon_path(pokemon)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(json_response[:id]).to eq(pokemon.id)
      end
    end
  end
end