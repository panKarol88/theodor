# frozen_string_literal: true

module AiFeatures
  class Knowledge
    include Helpers::LlmInterface

    def initialize(warehouse: nil)
      @warehouse = warehouse
    end

    def answer_question(question:)
      context = question_context(question)
      prompt = context + pre_question_prompt + question
      chat(prompt)
    end

    private

    attr_reader :warehouse

    # TODO: Refactor to rather use prompt decorators from DB than from hardcoded strings
    # :reek:FeatureEnvy
    def question_context(question)
      context_crumbs = Context::KnowledgeCollector.new(issue: question, warehouse:).find_related_data_crumbs(limit: 5)
      context = '\n ### CONTEXT ### \n'
      context += context_crumbs.map(&:content).join("\n")
      context += '\n ### END OF CONTEXT ### \n\n'
      context
    end

    def pre_question_prompt
      '\n Take a deep breath and calmly think about the question. \n' \
        '\n Take your time and read the context carefully. Line after line. \n' \
        '\n Please consider the given context and answer the following question as shortly as possible \n' \
        '\n If you are less than a 75% sure about the answer just return one word: \'dunno\'. \n'
    end
  end
end
