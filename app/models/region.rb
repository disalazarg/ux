class Region < ActiveRecord::Base
  extend FriendlyId

  has_many :provinces, inverse_of: :region
  has_many :districts, through: :provinces
  has_many :schools, through: :districts
  
  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
end
