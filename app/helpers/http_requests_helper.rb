module HttpRequestsHelper
  def send_post_request(url, payload, content_type = 'application/json')
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => content_type)
    request.body = payload
    response = http.request(request)
    response.body
  end

  def send_get_request(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.body
  end
end
