class Pick < ActiveRecord::Base
  belongs_to :answer
  belongs_to :alternative
  has_one :product, through: :answer
  has_one :question, through: :alternative

  delegate :question_id, to: :alternative, allow_nil: true

  scope :for_datapoint, -> { includes(:alternative).where(alternatives: { question_id: [1,3,4] }) }

  validates :answer,
    presence: true
  validates :alternative,
    presence: true
end
