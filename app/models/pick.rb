class Pick < ActiveRecord::Base
  belongs_to :answer
  belongs_to :alternative
  has_one :product, through: :answer
  has_one :question, through: :alternative

  delegate :question_id, to: :alternative, allow_nil: true

  validates :answer,
    presence: true
  validates :alternative,
    presence: true
end
