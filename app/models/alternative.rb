class Alternative < ActiveRecord::Base
  belongs_to :question
  has_many :picks, inverse_of: :alternative
  has_many :answers, through: :picks
  has_many :products, through: :picks

  delegate :to_s, to: :statement
end
