class Installation < ActiveRecord::Base
  has_one :oauth_token, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :rooms, dependent: :destroy
  
  validates :oauth_id, presence: true, uniqueness: true
  accepts_nested_attributes_for :oauth_token
end
