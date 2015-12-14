class HipchatConnect
  @@base_url ||= ENV['HIPCHAR_SERVER_URL'] || 'https://api.hipchat.com'

  attr_reader :conn
  attr_accessor :access_token

  def initialize(options = {})
    options.each { |k, v| self.send(:"#{k}=", v) }

    @conn ||= Faraday.new(url: @@base_url) do |b|
      b.request  :url_encoded
      b.response :logger
      b.adapter  Faraday.default_adapter
    end
  end

  def generate_token(options, user = nil, password = nil)
    conn.basic_auth(user, password) if user && password
    res = conn.post('/v2/oauth/token', options)
    if res.status == 200
      JSON.parse(res.body).with_indifferent_access
    else
      nil
    end
  end

  def send_notification(room_id_or_name, body)
    res = conn.post("/v2/room/#{room_id_or_name}/notification", body) do |req|
      req.headers['Authorization'] = "Bearer #{access_token}"
    end

    res.status == 204
  end

  def update_glance(room_id_or_name, body)
    res = conn.post("/v2/addon/ui/room/#{room_id_or_name}", body.to_json) do |req|
      req.headers['Authorization'] = "Bearer #{access_token}"
      req.headers['Content-Type'] = 'application/json'
    end

    res.status == 204
  end
end
