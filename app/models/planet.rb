class Planet < ApplicationRecord
  has_and_belongs_to_many :climates, inverse_of: :planet
  has_and_belongs_to_many :terrains, inverse_of: :planet

  validates :climates, presence: true
  validates :terrains, presence: true

  def set_defaults
    self.climates = [Climate.default] if self.climates.blank?
    self.terrains = [Terrain.default] if self.terrains.blank?
  end

  def build_climate_and_terrain(climates, terrains)
    self.climates = climates.map do |climate|
      Climate.find_or_initialize_by(description: climate)
    end if climates.present?
    self.terrains = terrains.map do |terrain|
      Terrain.find_or_initialize_by(description: terrain)
    end if terrains.present?
  end
end
