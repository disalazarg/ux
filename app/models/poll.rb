class Poll < ActiveRecord::Base
  extend FriendlyId

  belongs_to :product
  has_one :user, through: :product
  
  friendly_id :name, use: :slugged
end
