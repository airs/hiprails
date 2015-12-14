class OauthToken < ActiveRecord::Base
  belongs_to :installation

  validates :access_token, presence: true, uniqueness: true
end
