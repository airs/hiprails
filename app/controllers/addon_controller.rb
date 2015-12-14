class AddonController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :webhook

  def glance
    token = JWT.decode(params[:signed_request], nil, false).first
    installation = Installation.find_by(oauth_id: token['iss'])
    @count = if room = installation.rooms.find_by(hipchat_id: token['context']['room_id'])
      room.hips.count
    else
      0
    end
  end

  def webhook
    installation = Installation.find_by(oauth_id: params[:oauth_client_id])

    user = installation.users.find_or_create_by(hipchat_id: from_params[:id]) do |u|
      u.mention_name = from_params[:mention_name]
      u.name = from_params[:name]
    end

    room = installation.rooms.find_or_create_by(hipchat_id: room_params[:id]) do |r|
      r.archived = room_params[:is_archived]
      r.name = room_params[:name]
      r.privacy = room_params[:privacy]
      r.version = room_params[:version]
    end

    room.hips.create!(user: user)

    hc = HipchatConnect.new(access_token: installation.oauth_token.access_token)

    body = { message: "#{user.name} creates #{user.hips.count} hips." }
    hc.send_notification(room.hipchat_id, body)

    body = {
      glance: [
        content: {
          label: {
            type: 'html',
            value: "<strong>#{room.hips.count}</strong> hips"
          }
        },
        key: 'hiprails.glance'
      ]
    }
    hc.update_glance(room.hipchat_id, body)

    head :ok
  end

  private
    def from_params
      params[:item][:message][:from]
    end

    def room_params
      params[:item][:room]
    end
end
