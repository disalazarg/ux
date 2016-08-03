class Statute < ActiveRecord::Base
  extend FriendlyId

  has_many :schools, inverse_of: :statute

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
end
