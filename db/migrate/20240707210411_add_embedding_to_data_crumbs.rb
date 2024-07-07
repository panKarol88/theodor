# frozen_string_literal: true

class AddEmbeddingToDataCrumbs < ActiveRecord::Migration[7.1]
  def change
    add_column :data_crumbs, :embedding, :vector, limit: 1536, null: false
  end
end
