class Icdo < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_paragraph, against: :term_used, using: {
    tsearch: { prefix: true }
  }
  

  def match_icdo_codes(paragraph)
    Icdo.search_by_term_used(paragraph)
  end

end
