require "test_helper"

class PlanetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'set_defaults' do
    @planet = planets(:one).set_defaults
    @planet.save

    assert_equal(@planet.climates.count, 1)
    assert_equal(@planet.terrains.count, 1)
    assert_equal(@planet.climates.first.description, 'unknown')
    assert_equal(@planet.terrains.first.description, 'unknown')
  end

  test 'assign_climates_and_terrains' do
    @planet = planets(:one)
    @planet.assign_climates_and_terrains([climates(:one)],[terrains(:one)])

    assert_not_empty(@planet.climates)
    assert_not_empty(@planet.terrains)
  end

  test 'assign_climates_and_terrains with no params' do
    @planet = planets(:one)
    @planet.assign_climates_and_terrains(nil,nil)

    assert_empty(@planet.climates)
    assert_empty(@planet.terrains)
  end

  test 'assign_climates_and_terrains overrides' do
    @planet = planets(:one).set_defaults
    @planet.assign_climates_and_terrains([climates(:one)],[terrains(:one)])

    assert_not_equal(@planet.climates.first, 'unknown')
    assert_not_equal(@planet.terrains.first, 'unknown')
  end
end
