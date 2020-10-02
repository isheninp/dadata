## Dadata

### Description
Dadata API wrapper

### Install:

```ruby
gem install dadata
```
or 
```ruby
gem 'dadata'
```
### Usage:

```ruby
require 'dadata'

Dadata.configure do |config|
    config.url = "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address"
    config.api_key = "ded9fedccd33a614c9f3bd25fbc8e6c1168addd8"
end

api = Dadata::Address.new
req = api.call('Невский 48')
puts req.status
puts req.result["suggestions"]

```
### License
MIT License. Copyright 2020 Pavel Ishenin / isheninp@gmail.com
