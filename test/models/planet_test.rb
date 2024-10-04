require "test_helper"

class PlanetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'set_defaults' do
    planet = Planet.new(name: 'a', population: 0).set_defaults
    planet.save

    assert_equal(planet.climates.count, 1)
    assert_equal(planet.terrains.count, 1)
    assert_equal(planet.climates.first.description, 'unknown')
    assert_equal(planet.terrains.first.description, 'unknown')
  end
end
