class Climate < ApplicationRecord
  validates :description, uniqueness: true

  def self.default
    find_or_initialize_by(description: 'unknown')
  end
end
