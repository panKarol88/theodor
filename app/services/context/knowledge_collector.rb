# frozen_string_literal: true

module Context
  class KnowledgeCollector
    def initialize(issue:)
      @issue = issue
    end

    def find_related_data_crumbs
      issue_embedding = LlmTools::Embedding.new(input: issue).embed
      DataCrumb.nearest_neighbors(:embedding, issue_embedding, distance: 'euclidean').first(1)
    end

    private

    attr_reader :issue
  end
end
