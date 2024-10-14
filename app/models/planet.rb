class Planet < ApplicationRecord
  has_and_belongs_to_many :climates
  has_and_belongs_to_many :terrains
end
