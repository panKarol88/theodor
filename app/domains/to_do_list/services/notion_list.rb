module ToDoList
  module Services
    class NotionListError < StandardError; end
    class NotionList
      include HttpRequestsHelper

      NOTION_API_URL = 'https://api.notion.com/v1'.freeze

      def initialize(database_id:)
        @database_id = database_id
      end

      # :reek:FeatureEnvy
      def databases
        payload = { filter: { property: 'object', value: 'database' } }
        response = notion_request("#{NOTION_API_URL}/search", payload)

        response['results'].map do |item|
          { id: item['id'], title: item['title'][0].dig('text', 'content') }
        end
      end

      # ToDoList::Services::NotionList.new(database_id: '143dea0c-ba74-8104-8580-f58a4c054665').tasks(task_filter_params: { is_done: true, days_to_deadline: 7 })
      # :reek:FeatureEnvy
      def tasks(task_filter_params: {})
        response = notion_request(
          "#{NOTION_API_URL}/databases/#{database_id}/query",
          task_filter_properties(task_filter_params),
        )

        response['results'].map do |item|
          {
            id: item['id'],
            status: item.dig('properties', 'Status', 'formula', 'string'),
            is_important: item.dig('properties', 'Important', 'checkbox'),
            is_done: item.dig('properties', 'Done', 'checkbox'),
            is_urgent: item.dig('properties', 'Urgent', 'checkbox'),
            note: item.dig('properties', 'Note', 'rich_text', 0, 'plain_text'),
            deadline: item.dig('properties', 'Deadline', 'date', 'start'),
            task: item.dig('properties', 'Task', 'title', 0, 'plain_text')
          }
        end
      rescue NoMethodError => error
        Rails.logger.error(response)
        raise error
      end

      # ToDoList::Services::NotionList.new(database_id: '143dea0c-ba74-8104-8580-f58a4c054665').create_task(task_params: { is_important: false, is_done: false, is_urgent: false, note: nil, deadline: '2024-12-12', task: "eee" })
      def create_task(task_params:)
        raise NotionListError, 'Task is required' if task_params[:task].blank?

        payload = {
          'parent': { 'database_id': database_id },
          'properties': task_properties(task_params)
        }

        notion_request("#{NOTION_API_URL}/pages", payload)
      end

      # ToDoList::Services::NotionList.new(database_id: '143dea0c-ba74-8104-8580-f58a4c054665').update_task(page_id: '144dea0c-ba74-8186-9e0a-c4e728d549d2', task_params: { is_important: false, is_done: false, is_urgent: false, note: nil, deadline: '2024-12-12', task: "eee111" })
      def update_task(page_id:, task_params:)
        return if task_params.blank?

        payload = { 'properties': task_properties(task_params) }

        notion_request("#{NOTION_API_URL}/pages/#{page_id}", payload, 'patch')
      end

      private

      attr_reader :database_id

      def notion_integration_token
        ENV.fetch('NOTION_INTEGRATION_TOKEN')
      end

      def notion_version
        ENV.fetch('NOTION_API_VERSION')
      end

      def notion_request(url, payload = nil, method = 'post')
        response = HttpRequestsHelper::Requester.new(
          url:,
          payload: payload&.to_json,
          bearer_token: notion_integration_token,
          'Notion-Version': notion_version
        ).send(method)

        JSON.parse(response)
      end

      def task_properties(task_params)
        {}.tap do |properties|
          properties['Task'] = { 'type': 'title', 'title': [{ 'type': 'text', 'text': { 'content': task_params[:task] } }] } if task_params.key?(:task)
          properties['Important'] = { 'type': 'checkbox', 'checkbox': task_params[:is_important] } if task_params.key?(:is_important)
          properties['Done'] = { 'type': 'checkbox', 'checkbox': task_params[:is_done] } if task_params.key?(:is_done)
          properties['Urgent'] = { 'type': 'checkbox', 'checkbox': task_params[:is_urgent] } if task_params.key?(:is_urgent)
          properties['Deadline'] = { 'type': 'date', 'date': { 'start': task_params[:deadline] } } if task_params.key?(:deadline)
          properties['Note'] = { 'type': 'rich_text', 'rich_text': [{ 'type': 'text', 'text': { 'content': task_params[:note] } }] } if task_params.key?(:note)
        end
      end

      def task_filter_properties(task_search_params)
        return {} if task_search_params.blank?

        properties = []

        if task_search_params.key?(:is_done)
          properties << { 'property': 'Done', 'checkbox': { 'equals': task_search_params[:is_done] } }
        end

        if task_search_params.key?(:days_to_deadline)
          property = {
            'property': 'Deadline',
            'date': {
              'on_or_before': (Date.today + task_search_params[:days_to_deadline].to_i.days).strftime('%Y-%m-%d')
            }
          }
          properties << property
        end

        { 'filter': { 'and': properties } }
      end
    end
  end
end
