class Product < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :answers, inverse_of: :product
  has_many :picks,        through: :answers
  has_many :alternatives, through: :picks
  has_many :questions,    through: :alternatives

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
end
