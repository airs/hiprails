class InstallationsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    hc = HipchatConnect.new
    options = { grant_type: 'client_credentials', scope: 'send_notification' }
    token = hc.generate_token(options, params[:oauthId], params[:oauthSecret])
    unless token
      render text: 'Generating OAuth token is failed.', status: :internal_server_error
      return
    end

    installation = Installation.where(oauth_id: params[:oauthId]).first_or_initialize
    installation.attributes = installation_params.merge(oauth_token_attributes: token)
    installation.save!

    if installation.room_id.present?
      hc = HipchatConnect.new(access_token: installation.oauth_token.access_token)
      body = { message: "Ping" }
      hc.send_notification(installation.room_id, body)
    end

    head :ok
  end

  def destroy
    installation = Installation.find_by(oauth_id: params[:id])
    installation.destroy

    head :ok
  end

  private
    def installation_params
      org_params = params.permit(:oauthId, :capabilitiesUrl, :roomId, :groupId)
      Hash[org_params.map { |k,v| [k.underscore, v] }].with_indifferent_access
    end
end
