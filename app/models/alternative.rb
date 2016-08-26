class Alternative < ActiveRecord::Base
  belongs_to :question
  has_many :picks, inverse_of: :alternative

  delegate :to_s, to: :statement
end
