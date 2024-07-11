# frozen_string_literal: true

module Theodor
  module V1
    module DataCrumbs
      class Index < API
        desc 'Return all Data Crumbs.'
        get do
          DataCrumb.all
        end
      end
    end
  end
end
