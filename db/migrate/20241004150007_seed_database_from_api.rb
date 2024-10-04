class SeedDatabaseFromApi < ActiveRecord::Migration[7.2]
  def up
    require 'net/http'

    uri = URI.parse("https://swapi-graphql.netlify.app")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new("/.netlify/functions/index")
    request.content_type = 'application/json'
    request.body = {query: '{allPlanets{planets{name population terrains climates}}}'}.to_json
    JSON.parse(http.request(request).body).dig('data', 'allPlanets', 'planets').each do |planet|
      record = Planet.new(name: planet['name'], population: planet['population'].to_i)

      record.climates = planet['climates'].map do |climate|
        Climate.find_or_initialize_by(description: climate)
      end
      record.terrains = planet['terrains'].map do |terrain|
        Terrain.find_or_initialize_by(description: terrain)
      end

      record.save!
    end
  end

  def down
    Terrain.destroy_all
    Climate.destroy_all
    Plant.destroy_all
  end
end
