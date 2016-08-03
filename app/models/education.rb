class Education < ActiveRecord::Base
  extend FriendlyId

  has_many :schools, inverse_of: :education

  friendly_id :name, use: :slugged

  delegate :to_s, to: :name
end
