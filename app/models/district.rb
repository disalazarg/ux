class District < ActiveRecord::Base
  extend FriendlyId

  has_one :region, through: :province
  belongs_to :province
  has_many :schools, inverse_of: :district

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
end
