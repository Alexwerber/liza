# frozen_string_literal: true

# Copyright (c) 2019 Danil Pismenny <danil@brandymint.ru>

class TransactionDecorator < ApplicationDecorator
  delegate_all

  def self.table_columns
    %i[id currency reference txid from_address to_address amount block_number txout status options fee]
  end

  def from_address
    [h.link_to(object.from_address, object.blockchain.explore_address_url(object.from_address), target: '_blank'), present_owner(address_owner(object.from_address))].join('<br>').html_safe
  end

  def to_address
    [h.link_to(object.to_address, object.blockchain.explore_address_url(object.to_address), target: '_blank'), present_owner(address_owner(object.to_address))].join('<br>').html_safe
  end

  def txid
    h.link_to object.txid, object.transaction_url, target: '_blank'
  end

  private

  def address_owner(address)
    PaymentAddress.find_by(address: address) || Wallet.find_by(address: address)
  end

  def present_owner(address_owner)
    case address_owner
    when PaymentAddress
      h.present_payment_address(address_owner)
    when Wallet
      h.present_wallet(address_owner)
    else
      'Unknown address_owner'
    end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
