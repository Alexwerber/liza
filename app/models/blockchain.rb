class Blockchain < ApplicationRecord
  has_many :wallets
  has_many :withdraws
  has_many :currencies
  has_many :payment_addresses
  has_many :transactions, through: :currencies
  has_many :deposits, through: :currencies

  def native_currency
    currencies.find { |c| c.parent_id.nil? } || raise("No native currency for wallet id #{id}")
  end

  def to_s
    key
  end

  def explore_address_url(address)
    explorer_address.gsub('#{address}', address)
  end

  def explore_transaction_url(txid)
    explorer_transaction.gsub('#{txid}', txid)
  end
end
