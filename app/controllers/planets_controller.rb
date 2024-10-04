class PlanetsController < ApplicationController
  # GET /planets/1
  def show
    @planet = Planet.includes(:climates, :terrains).find_by(name: params[:id])
    render json: @planet.as_json(only: [:name, :population]).
                         merge({climates: @planet.climates.map(&:description)}).
                         merge({terrains: @planet.terrains.map(&:description)})
  end

  # POST /planets
  def create
    @planet = Planet.new(planet_params.permit(:name, :population))
    @planet.assign_climates_and_terrains(climates_params, terrains_params)
    @planet.set_defaults

    if @planet.save
      render json: @planet, status: :created, location: @planet
    else
      render json: @planet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /planets/1
  def update
    @planet = Planet.find_by(name: params[:id])
    @planet.assign_attributes(planet_params.permit(:name, :population))
    @planet.assign_climates_and_terrains(climates_params, terrains_params)

    if @planet.save
      render json: @planet
    else
      render json: @planet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /planets/1
  def destroy
    @planet = Planet.find_by(name: params[:id])
    @planet.destroy!
  end

  private
    # Only allow a list of trusted parameters through.
    def planet_params
      params.require(:planet).permit(:name, :population)
    end

    def climates_params
      params.require(:planet).permit(climates: [])['climates']
    end

    def terrains_params
      params.require(:planet).permit(terrains: [])['terrains']
    end
end
