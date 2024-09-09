class TreatmentFollowUp < ApplicationRecord
  belongs_to :present
  belongs_to :death_stat
  belongs_to :refer_from
  belongs_to :refer_to
end
