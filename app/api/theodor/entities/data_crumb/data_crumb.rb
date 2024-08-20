# frozen_string_literal: true

module Theodor
  module Entities
    module DataCrumb
      class DataCrumb < Grape::Entity
        expose :id, documentation: { type: 'string', desc: 'DataCrumb id' }
        expose :content, documentation: { type: 'string', desc: 'DataCrumb content' }
        expose :warehouse_id, documentation: { type: 'string', desc: 'DataCrumb warehouse id' }
        expose :embedding_sample, documentation: { type: 'string', desc: 'DataCrumb embedding sample.' } do |data_crumb|
          data_crumb.embedding.first(10)
        end
      end
    end
  end
end
