class Product < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :polls, inverse_of: :product

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
end
