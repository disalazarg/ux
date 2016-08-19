class Poll < ActiveRecord::Base
  extend FriendlyId

  belongs_to :product
  has_one :user, through: :product
  has_many :questions, inverse_of: :poll
  
  friendly_id :title, use: :slugged

  delegate :to_s, to: :title
end
