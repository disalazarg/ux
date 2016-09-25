class Alternative < ActiveRecord::Base
  belongs_to :question
  has_many :picks, inverse_of: :alternative
  has_many :answers, through: :picks
  has_many :products, through: :picks

  delegate :to_s, to: :statement

  scope :for_datapoint, -> () { where(question_id: [1,3,4]) }
end
