# frozen_string_literal: true

module DataCrumbs
  class Builder
    include Helpers::LlmInterface

    def initialize(content:, warehouse: nil)
      @content = content
      @warehouse = warehouse
    end

    def embed_and_create!
      embed_and_create
    end

    def embed_and_initialize
      DataCrumb.new(embedding: embed(content), content:, warehouse:)
    end

    private

    attr_reader :content, :warehouse

    def embed_and_create
      DataCrumb.create!(embedding: embed(content), content:, warehouse:)
    end
  end
end
