# frozen_string_literal: true

class Deposit < ApplicationRecord
  STATES = %i[submitted canceled rejected accepted collected skipped processing fee_processing].freeze
  COMPLETED_STATES = (STATES - %i[submitted]).freeze

  serialize :spread, Array
  serialize :from_addresses, Array
  serialize :data, JSON unless Rails.configuration.database_support_json

  extend Enumerize
  TRANSFER_TYPES = { fiat: 100, crypto: 200 }.freeze

  belongs_to :currency, required: true
  belongs_to :member, required: true
  scope :completed, -> { where(aasm_state: COMPLETED_STATES) }
  scope :uncompleted, -> { where.not(aasm_state: COMPLETED_STATES) }

  enumerize :aasm_state, in: STATES, predicates: true

  scope :recent, -> { order(id: :desc) }

  def account
    member&.get_account(currency)
  end

  def completed?
    aasm_state.in?(COMPLETED_STATES.map(&:to_s))
  end

   def self.ransackable_scopes(auth_object = nil)
     %i(uncompleted completed) + super
   end
end
