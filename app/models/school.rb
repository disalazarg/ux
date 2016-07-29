class School < ActiveRecord::Base
  extend FriendlyId

  has_one :province, through: :district
  has_one :region, through: :province
  belongs_to :district

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
end
