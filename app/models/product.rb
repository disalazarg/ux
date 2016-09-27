class Product < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :answer
  has_many :answers, inverse_of: :product
  has_many :picks,        through: :answers
  has_many :alternatives, through: :picks
  has_many :questions,    through: :alternatives
  has_many :schools,      through: :answers

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
end
