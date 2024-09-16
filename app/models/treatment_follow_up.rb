class TreatmentFollowUp < ApplicationRecord
  belongs_to :present, optional: true
  belongs_to :death_stat, optional: true
  belongs_to :refer_from, class_name: 'Hospital', optional: true
  belongs_to :refer_to, class_name: 'Hospital', optional: true

  
  def as_json(options = {})
    hsh = super(options.merge(except: [:present_id, :death_stat_id, :refer_from_id, :refer_to_id])).merge(
      present: present,
      death_stat: death_stat,
      refer_from: refer_from,
      refer_to: refer_to,
    )
    hsh
  end

end
