# https://dadata.ru/
# 
# api = ::Dadata::Address.new
# result = api.call(text)

=begin  

API подсказок по адресам

curl -X POST \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "Authorization: Token ${API_KEY}" \
-d '{ "query": "москва хабар" }' \
https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address

=end

require 'rubygems'
require 'ostruct'
require 'json'
require 'dadata_ru/http_client/base'
  
module DadataRu
  
  def self.config
    @config ||= OpenStruct.new
  end
      
  def self.configure
    yield(config)
  end

  class Address < HttpClient

    ERRORS = {
      '200' =>'Запрос успешно обработан',
      '400' =>'Некорректный запрос (невалидный JSON или XML)',
      '401' =>'В запросе отсутствует API-ключ',
      '403' =>'В запросе указан несуществующий API-ключ Или не подтверждена почта Или исчерпан дневной лимит по количеству запросов',
      '405' =>'Запрос сделан с методом, отличным от POST',
      '429' =>'Слишком много запросов в секунду или новых соединений в минуту',
      '500' =>'Произошла внутренняя ошибка сервиса'
    }

    def error code
      ERRORS[code]
    end

    def call query
      submit(
        url: DadataRu.config.url,
        headers: {
          "Authorization"=>"Token "+ DadataRu.config.api_key.to_s,
          "Accept": "application/json"},
        method: 'POST', 
        type: 'json', 
        body: {query: query}.to_json
      )
    end

  end
end
