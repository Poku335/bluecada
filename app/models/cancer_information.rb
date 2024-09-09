class CancerInformation < ApplicationRecord
  belongs_to :basis
  belongs_to :topography_code
  belongs_to :laterality
  belongs_to :behavior
  belongs_to :lab
  belongs_to :stage
  belongs_to :stage_other
  belongs_to :extent
  belongs_to :metastasis_site
  belongs_to :grad
  belongs_to :icdo
end
