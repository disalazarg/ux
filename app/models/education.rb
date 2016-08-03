class Education < ActiveRecord::Base
  extend FriendlyId

  has_many :schools, inverse_of: :education

  friendly_id :name, use: :slugged
end
