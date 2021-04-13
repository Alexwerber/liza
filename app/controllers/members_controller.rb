# frozen_string_literal: true

class MembersController < ApplicationController
  include CurrencySupport

  layout 'fluid'

  def show
    render locals: { member: Member.find(params[:id]) }
  end
end
