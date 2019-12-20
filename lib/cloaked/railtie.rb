# frozen_string_literal: true

require 'rails/railtie'

module Cloaked
  class Railtie < Rails::Railtie
    config.eager_load_namespaces << Cloaked
  end
end
