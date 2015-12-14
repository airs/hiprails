class Room < ActiveRecord::Base
  belongs_to :installation
  has_many :hips, dependent: :delete_all
  validates :hipchat_id, presence: true
end
