module GraphDb
  class Client
    def nodes_where(label:, **properties)
      payload = {
        statements: [
          {
            statement: "MATCH (n:#{label}) WHERE #{properties.map { |key, value| property_parser(key, value) }.join(', ')} RETURN n;",
          }
        ]
      }.to_json

      neo4j_query(payload)['results']
    end

    def create_node(label:, properties: {})
      payload = {
        statements: [
          {
            statement: "CREATE (n:#{label} $properties) RETURN n",
            parameters: {
              properties: properties
            }
          }
        ]
      }.to_json

      neo4j_query(payload)
    end

    def create_relationship(n_element_id:, m_element_id:, relation:)
      payload = {
        statements: [
          {
            statement: "MATCH (n), (m) WHERE elementId(n) = '#{n_element_id}' AND elementId(m) = '#{m_element_id}' CREATE (n)-[r:#{relation}]->(m);"
          }
        ]
      }.to_json

      neo4j_query(payload)
    end

    def shortest_path(n_element_id:, m_element_id:)
      payload = {
        statements: [
          {
            statement: "  MATCH (a), (b) WHERE elementId(a) = '#{n_element_id}' AND elementId(b) = '#{m_element_id}' MATCH path = shortestPath((a)-[*]-(b)) RETURN [n IN nodes(path) | properties(n)] AS node_properties;"
          }
        ]
      }.to_json

      neo4j_query(payload)
    end

    # GraphDb::Client.new.purge_whole_db
    def purge_whole_db
      payload = {
        statements: [
          {
            statement: 'MATCH (n) DETACH DELETE n',
          }
        ]
      }.to_json

      neo4j_query(payload)
    end

    private

    def neo4j_query(payload)
      url = "#{neo4j_url}/db/#{neo4j_database}/tx/commit"
      basic_auth = [neo4j_username, neo4j_password]

      response = HttpRequestsHelper::Requester.new(url:, payload:, basic_auth:).post
      JSON.parse(response)
    end

    def neo4j_url
      ENV.fetch('NEO4J_URL')
    end

    def neo4j_database
      ENV.fetch('NEO4J_DATABASE')
    end

    def neo4j_username
      ENV.fetch('NEO4J_USERNAME')
    end

    def neo4j_password
      ENV.fetch('NEO4J_PASSWORD')
    end

    def property_parser(key, value)
      "n.#{key} = #{value.is_a?(String) ? "'#{value}'" : value}"
    end
  end
end

# GraphDb::Client.new.purge_whole_db
