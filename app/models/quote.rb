# frozen_string_literal: true

# Quote class
class Quote < ApplicationRecord
  belongs_to :company

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }
  # after_create_commit lambda {
  #                       broadcast_prepend_to 'quotes', partial: 'quotes/quote', locals: { quote: self },
  #                                                      target: 'quotes'
  #                     }

  # Using ruby's synctactic sugar
  # after_create_commit -> { broadcast_prepend_later_to 'quotes' }
  # after_update_commit -> { broadcast_replace_later_to 'quotes' }
  # after_destroy_commit -> { broadcast_remove_to 'quotes' }

  # Using ruby's synctactic sugar
  broadcasts_to ->(quote) { [quote.company, 'quotes'] }, inserts_by: :prepend
end
