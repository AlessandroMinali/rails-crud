class Planet < ApplicationRecord
  has_and_belongs_to_many :climates
  has_and_belongs_to_many :terrains

  validates :name, uniqueness: true
  validates :population, numericality: { only_integer: true }, comparison: {greater_than_or_equal_to: 0}

  def set_defaults
    self.climates = [Climate.default] if self.climates.empty?
    self.terrains = [Terrain.default] if self.terrains.empty?
    self
  end

  def assign_climates_and_terrains(c, t)
    self.climates = c.map do |climate|
      Climate.new(description: climate)
    end unless c.blank?
    self.terrains = t.map do |terrain|
      Terrain.new(description: terrain)
    end unless t.blank?
    self
  end
end
