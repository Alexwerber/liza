# Copyright (c) 2019 Danil Pismenny <danil@brandymint.ru>

# frozen_string_literal: true

class CurrenciesController < ResourcesController
  include CurrencySupport
  layout 'fluid'
end