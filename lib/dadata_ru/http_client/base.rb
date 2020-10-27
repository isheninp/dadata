require 'net/http'
require 'uri'
require 'json'

module DadataRu
  class HttpClient
    def submit url:, headers: {}, params: {}, method: 'GET', type: 'json', body: ''
      uri = URI.parse(url)
      uri.query = URI.encode_www_form(params) unless params == {}
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.read_timeout = 10
      headers.merge! case type
      when 'json'
        {'Content-Type' => 'application/json'}
      when 'text'
        {'Content-Type' => 'text/html'}
      else 
        raise 'unknown type'
      end
      response = case method
      when 'GET'
        http.get(uri.request_uri, headers)
      when 'POST'
        http.post(uri.request_uri, body, headers)
      else
        raise 'Unknown http method'
      end
      raise "API error #{response.code}" if response.code != "200"
      result = case type
      when 'json'
        JSON.parse(response.body)
      when 'text'
        response.body
      end
      OpenStruct.new({status: "success", result: result})
    rescue => error
      OpenStruct.new({ status: "error", result: error })
    end
  end
end