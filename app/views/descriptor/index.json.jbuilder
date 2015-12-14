json.key 'hiprails'
json.name 'HipRails'
json.description 'A simple add-on build with Ruby on Rails.'

json.vender do
  json.name 'Masakuni Kato'
  json.url 'https://www.airs.co.jp/'
end

json.links do
  json.self root_url
  json.homepage root_url
end

json.capabilities do
  json.hipchatApiConsumer do
    json.scopes %w(send_notification)
  end

  json.installable do
    json.callbackUrl installations_url
  end

  json.webhook do
    json.url webhook_url
    json.pattern '^/hip'
    json.event 'room_message'
    json.name 'HipRails'
  end

  json.set! :glance do
    json.array! %w(glance) do |key|
      json.key "hiprails.#{key}"
      json.name do
        json.value 'HipRails Glance'
      end
      json.queryUrl glance_url
      json.icon do
        json.url image_url('logo.png')
        json.set! 'url@2x', image_url('logo.png')
      end
    end
  end
end
