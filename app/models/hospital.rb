class Hospital < ApplicationRecord

  def self.cached_hospitals
    Rails.cache.fetch('hospitals', expires_in: 12.hours) do
      Hospital.all.to_a
    end
  end
  
end
