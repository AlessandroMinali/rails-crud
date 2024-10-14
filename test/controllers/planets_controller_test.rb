require "test_helper"

class PlanetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planet = planets(:one)
  end

  test "should create planet" do
    assert_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name.reverse, population: @planet.population } }, as: :json
    end

    assert_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name.reverse.upcase, population: @planet.population } }, as: :json
    end

    assert_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name[..2], population: @planet.population, climates: [ "freezing" ], terrains: [ "flat" ] } }, as: :json
      @planet = Planet.last
      assert_equal(@planet.climates.first.description, "freezing")
      assert_equal(@planet.terrains.first.description, "flat")
    end

    assert_raises ActiveRecord::RecordNotUnique do
      post planets_url, params: { planet: { name: @planet.name, population: @planet.population } }, as: :json
    end

    assert_response :created
  end

  test "should show planet" do
    get planet_url(@planet.name), as: :json
    assert_response :success
  end

  test "should update planet" do
    patch planet_url(@planet.name), params: { planet: { name: @planet.name, population: @planet.population * 1000 } }, as: :json
    assert_response :success
    assert_equal(@planet.reload.population, 1000)

    patch planet_url(@planet.name), params: { planet: { name: @planet.name, population: @planet.population, climates: [], terrains: [] } }, as: :json
    assert_response :success
    assert_equal(@planet.climates.first.description, "unknown")
    assert_equal(@planet.terrains.first.description, "unknown")

    patch planet_url(@planet.name), params: { planet: { name: @planet.name, population: @planet.population, climates: [ "rainy", "loud" ], terrains: [ "alien", "soft" ] } }, as: :json
    assert_response :success
    assert_equal(@planet.climates.count, 2)
    assert_equal(@planet.terrains.count, 2)
    assert_equal(@planet.climates.first.description, "rainy")
    assert_equal(@planet.terrains.first.description, "alien")
  end

  test "should destroy planet" do
    assert_difference("Planet.count", -1) do
      delete planet_url(@planet.name), as: :json
    end

    assert_response :no_content
  end
end
