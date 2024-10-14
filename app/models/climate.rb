class Climate < ApplicationRecord
  def self.default
    find_or_initialize_by(description: "unknown")
  end
end
