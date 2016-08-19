class Alternative < ActiveRecord::Base
  belongs_to :question
  has_many :picks, inverse_of: :alternative
end
