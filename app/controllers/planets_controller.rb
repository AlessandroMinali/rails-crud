class PlanetsController < ApplicationController
  # GET /planets/1
  def show
    @planet = Planet.includes(:terrains, :climates).
                     find_by_name(params[:id])

    render json: @planet.as_json(only: [:name, :population]).
                         merge({terrains: @planet.terrains.pluck(:description)}).
                         merge({climates: @planet.climates.pluck(:description)})
  end

  # POST /planets
  def create
    @planet = Planet.new(name: planet_params['name'], population: planet_params['population'])
    @planet.build_climate_and_terrain(planet_params['climates'], planet_params['terrains'])
    @planet.set_defaults

    if @planet.save
      render json: @planet, status: :created, location: @planet
    else
      render json: @planet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /planets/1
  def update
    @planet = Planet.find_by_name(params[:id])
    @planet.assign_attributes(name: planet_params['name'], population: planet_params['population'])
    @planet.build_climate_and_terrain(planet_params['climates'], planet_params['terrains'])

    if @planet.save
      render json: @planet
    else
      render json: @planet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /planets/1
  def destroy
     @planet = Planet.find_by_name!(params[:id]).destroy!
  end

  private
    # Only allow a list of trusted parameters through.
    def planet_params
      params.require(:planet).permit(:name, :population, climates: [], terrains: [])
    end
end
