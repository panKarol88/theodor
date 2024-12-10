# S03E03 - Zadanie 1

module AiDevs3
  module Exercises
    class Database < Exercise
      def send_query(query)
        payload = {
          task: 'database',
          apikey: ENV.fetch('AI_DEVS_API_KEY', nil),
          query:
        }.to_json

        JSON.parse(send_post_request('https://centrala.ag3nts.org/apidb', payload))['reply']
      end

      def database_context
        table_names = send_query('show tables').pluck('Tables_in_banan')
        table_structures = table_names.map { |table_name| send_query("show create table #{table_name}") }

        table_structures
      end

      def answer_query(task = 'Return a list of active datacenters that are managed by managers that are currently inactive.')
        message = "#{task}"
        message += 'To achieve that, you need to follow the rules and examples below.'
        message += "<database_structure>\n#{database_context}\n</database_structure>\n"
        message += '<rules>\n'
        message += '- Process the task step-by-step.\n'
        message += '- Go through the database structure and print a short interpretation of each table.\n'
        message += '- Think about the task and decide which table and which column is relevant to build a query.\n'
        message += '- Finally, in the last line return the generated SQL query between the <query> markers, like described in examples below.\n'
        message += '</rules>\n'
        message += '<example1>\n'
        message += '<task>Provide me a list of all users with username Adrian</task>'
        message += '<query>SELECT * FROM users WHERE username = "Adrian";</query>'
        message += '</example1>\n'
        message += '<example2>\n'
        message += '<task>How many connections thare are for user with id 1</task>'
        message += '<query>SELECT COUNT(*) FROM connections WHERE user1_id = "1";</query>'
        message += '</example2>\n\n\n'
        message += "<task>#{task}</task>"

        generated_query = chat(message)[:content]
        p generated_query
        generated_query[generated_query.index('<query>')...generated_query.index('</query>')].gsub('<query>', '').gsub('</query>', '')
      end

      def answer(task)
        send_query(answer_query(task))
      end
    end
  end
end

# AiDevs3::Exercises::Database.new.answer

# AiDevs3::Exercises::Database.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'DATABASE').send_answer
