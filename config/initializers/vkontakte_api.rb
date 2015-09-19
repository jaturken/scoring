VkontakteApi.configure do |config|
  # параметры, необходимые для авторизации средствами vkontakte_api
  # (не нужны при использовании сторонней авторизации)
  config.app_id       = '5075731'
  config.app_secret   = 'J6krEcwIzHGaBnA0dzsn'
  config.redirect_uri = 'http://api.vkontakte.ru/blank.html'
  # faraday-адаптер для сетевых запросов
  config.adapter = :net_http
  # HTTP-метод для вызова методов API (:get или :post)
  config.http_verb = :post
  # максимальное количество повторов запроса при ошибках
  config.max_retries = 2

  # логгер
  # config.log_requests  = true  # URL-ы запросов
  # config.log_errors    = true  # ошибки
  config.log_responses = false # удачные ответы

  # используемая версия API
  # config.api_version = '5.21'
end
