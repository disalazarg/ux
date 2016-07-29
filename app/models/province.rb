class Province < ActiveRecord::Base
  extend FriendlyId

  belongs_to :region
  has_many :districts, inverse_of: :province
  has_many :schools, through: :districts

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
end
