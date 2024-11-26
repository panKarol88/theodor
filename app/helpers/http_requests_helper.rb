module HttpRequestsHelper
  class Requester
    def initialize(url:, payload: {}, bearer_token: nil, basic_auth: nil, **headers)
      @url = url
      @payload = payload
      @basic_auth = basic_auth
      @headers = sanitized_headers(headers, bearer_token)
    end

    def post
      send_request do |uri|
        Net::HTTP::Post.new(uri.request_uri, headers)
      end
    end

    def get
      send_request do |uri|
        Net::HTTP::Get.new(uri.request_uri, headers)
      end
    end

    def patch
      send_request do |uri|
        Net::HTTP::Patch.new(uri.request_uri, headers)
      end
    end

    private

    attr_reader :url, :headers, :payload, :basic_auth

    def sanitized_headers(headers, bearer_token)
      headers['Content-Type'] ||= 'application/json'
      headers['Authorization'] ||= "Bearer #{bearer_token}" if bearer_token
      headers
    end

    def send_request
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = url.split('://').first == 'https'
      request = yield(uri)
      request.body = payload if payload.present?
      request.basic_auth(basic_auth[0], basic_auth[1]) if basic_auth.present?
      response = http.request(request)
      response.body
    end
  end

  # ---------------------------------------------------------------------------------------
  # support deprecated method names
  # TODO: remove in the future
  def send_post_request(url, payload, content_type = 'application/json')
    HttpRequestsHelper::Requester.new(url:, payload:, 'content_type': content_type).post
  end

  def send_get_request(url)
    HttpRequestsHelper::Requester.new(url:).get
  end
  # ---------------------------------------------------------------------------------------
end
