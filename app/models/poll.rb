class Poll < ActiveRecord::Base
  extend FriendlyId

  belongs_to :product
  has_one :user, through: :product
  has_many :questions, inverse_of: :poll
  has_many :polled, inverse_of: :poll
  has_many :contacts, through: :polled
  
  friendly_id :title, use: :slugged

  delegate :to_s, to: :title
end
