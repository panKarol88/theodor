# frozen_string_literal: true

module Context
  class KnowledgeCollector
    def initialize(issue:, warehouse:)
      @issue = issue
      @warehouse = warehouse
    end

    def find_related_data_crumbs(limit: 1)
      issue_embedding = LlmTools::Embedding.new(input: issue).embed
      data_crumbs_collection.nearest_neighbors(:embedding, issue_embedding, distance: 'euclidean').first(limit)
    end

    private

    attr_reader :issue, :warehouse

    def data_crumbs_collection
      @data_crumbs_collection ||= warehouse&.data_crumbs || DataCrumb.all
    end
  end
end
