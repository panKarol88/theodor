# frozen_string_literal: true

module DataCrumbs
  class Builder
    include Helpers::LlmInterface

    def initialize(content:, warehouse: nil)
      @content = content
      @warehouse = warehouse
    end

    def embed_and_create
      embed_and_initialize
      data_crumb.save!

      data_crumb
    end

    def embed_and_initialize
      @data_crumb = DataCrumb.new(embedding: embed(content), content:, warehouse:)
    end

    private

    attr_reader :content, :warehouse, :data_crumb
  end
end
