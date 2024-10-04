require "test_helper"

class PlanetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planet = planets(:one)
  end
  test "should create planet" do
    assert_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name.reverse, population: @planet.population } }, as: :json
    end

    assert_equal(Planet.last.climates.count, 1)
    assert_equal(Planet.last.climates.first.description, 'unknown')
    assert_equal(Planet.last.terrains.count, 1)
    assert_equal(Planet.last.terrains.first.description, 'unknown')

    assert_response :created
  end

  test "should not create planet with dup name" do
    assert_no_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name, population: @planet.population } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should not create planet with invalid population" do
    assert_no_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name, population: nil } }, as: :json
    end

    assert_response :unprocessable_entity

    assert_no_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name, population: -1 } }, as: :json
    end

    assert_response :unprocessable_entity

    assert_no_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name, population: 'asd' } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should create planet with climates" do
    assert_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name.reverse, population: @planet.population, climates: ['arid', 'snowy'] } }, as: :json
    end

    assert_equal(Planet.last.climates.count, 2)
    assert_equal(Planet.last.climates.first.description, 'arid')

    assert_response :created
  end

  test "should create planet with terrains" do
    assert_difference("Planet.count") do
      post planets_url, params: { planet: { name: @planet.name.reverse, population: @planet.population, terrains: ['mountains', 'oceans'] } }, as: :json
    end

    assert_equal(Planet.last.terrains.count, 2)
    assert_equal(Planet.last.terrains.first.description, 'mountains')

    assert_response :created
  end

  test "should show planet" do
    get planet_url(@planet.name), as: :json
    assert_response :success
  end

  test "should update planet" do
    patch planet_url(@planet.name), params: { planet: { name: @planet.name, population: @planet.population } }, as: :json
    assert_response :success
  end

  test "should not update planet with dup name" do
    patch planet_url(@planet.name), params: { planet: { name: planets(:two).name, population: @planet.population } }, as: :json

    assert_response :unprocessable_entity
  end

  test "should not update planet with invalid population" do
    assert_no_difference("Planet.count") do
      patch planet_url(@planet.name), params: { planet: { name: @planet.name, population: nil } }, as: :json
    end

    assert_response :unprocessable_entity

    assert_no_difference("Planet.count") do
      patch planet_url(@planet.name), params: { planet: { name: @planet.name, population: -1 } }, as: :json
    end

    assert_response :unprocessable_entity

    assert_no_difference("Planet.count") do
      patch planet_url(@planet.name), params: { planet: { name: @planet.name, population: 'asd' } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should update planet with climates" do
    assert_no_difference("Planet.count") do
      patch planet_url(@planet.name), params: { planet: { name: @planet.name.reverse, population: @planet.population, climates: ['arid', 'snowy'] } }, as: :json
    end

    assert_equal(Planet.last.climates.count, 2)
    assert_equal(Planet.last.climates.first.description, 'arid')

    assert_response :success
  end

  test "should update planet with terrains" do
    assert_no_difference("Planet.count") do
      patch planet_url(@planet.name), params: { planet: { name: @planet.name.reverse, population: @planet.population, terrains: ['mountains', 'oceans'] } }, as: :json
    end

    assert_equal(Planet.last.terrains.count, 2)
    assert_equal(Planet.last.terrains.first.description, 'mountains')

    assert_response :success
  end

  test "should destroy planet" do
    assert_no_difference("Terrain.count", -1) do
      assert_no_difference("Climate.count", -1) do
        assert_difference("Planet.count", -1) do
          delete planet_url(@planet.name), as: :json
        end
      end
    end

    assert_response :no_content
  end
end
