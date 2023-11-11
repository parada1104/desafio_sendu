namespace :poke_api do
  desc 'Create pokemon from pokeapi.co'
  # Todo - refactor logic and names to apply either dto o better data management
  # Todo - manage request errors and timeouts
  # Todo - better logging level
  task fetch_pokemon: :environment do
    batch_size = 100
    offset = 0
    total_imported = 0

    loop do
      list_url = "https://pokeapi.co/api/v2/pokemon?limit=#{batch_size}&offset=#{offset}"
      list_response = Typhoeus.get(list_url)
      pokemon_results = JSON.parse(list_response.body)
      pokemon_urls = pokemon_results["results"].map { |pokemon| pokemon["url"] }

      break if pokemon_urls.empty?
      puts "Importing #{pokemon_urls.size} Pokemons"

      hydra = Typhoeus::Hydra.new
      pokemon_attributes = []

      pokemon_urls.each do |url|
        request = Typhoeus::Request.new(url, method: :get)
        request.on_complete do |response|
          pokemon_data = JSON.parse(response.body)
          pokemon_types = pokemon_data["types"].map { |type| type["type"]["name"] }
          pokemon_types = pokemon_types.map { |type| Typeable.find_or_create_by!(name: type) }
          pokemon_instance = Pokemon.new({
                                           name: pokemon_data["name"],
                                           order: pokemon_data["order"],
                                           base_experience: pokemon_data["base_experience"],
                                           weight: pokemon_data["weight"],
                                           height: pokemon_data["height"],
                                           type_ids: pokemon_types.map(&:id)
                                         })
          pokemon_attributes << pokemon_instance
        end
        hydra.queue(request)
      end

      hydra.run
      Pokemon.import pokemon_attributes, validate: true
      total_imported += pokemon_attributes.size
      offset += batch_size
    end
    puts "Import completed with #{total_imported} Pokemons"
  end
end