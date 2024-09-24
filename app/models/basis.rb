class Basis < ApplicationRecord
  def self.cached_basis
    Rails.cache.fetch('basis', expires_in: 12.hours) do
      Basis.all.to_a
    end
  end
end
