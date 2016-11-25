class Answer < ActiveRecord::Base
  belongs_to :contact
  belongs_to :product
  has_one  :school, through: :contact
  has_many :picks, inverse_of: :answer
  has_many :alternatives, through: :picks

  accepts_nested_attributes_for :picks

  delegate :name, to: :school, prefix: true, allow_nil: true
  delegate :rbd,  to: :school, prefix: true, allow_nil: true
  delegate :to_row, to: :school, prefix: true, allow_nil: true
  delegate :email, to: :contact, prefix: true, allow_nil: true

  validate :all_picked
  validate :is_unique

  scope :internal, -> { where(contact: nil) }
  scope :external, -> { where.not(contact: nil) }

  def all_picked
    if contact and picks.length < 5 then
      errors.add :picks, "Todas las alternativas deben ser respondidas"
    end
  end

  def is_unique
    answers = Answer
      .where(product_id: product_id, contact_id: contact_id)
      .order(:created_at)
      .last(2)
      .map(&:created_at)
      .map(&:to_date)
      .map(&:mjd)

    if answers.length > 1 and answers.reduce(&:-) > 90 then
      errors.add :contact_id, "Usted ya respondió esta encuesta"
    end
  end

  def to_graphpoint
    data = self
      .picks
      .select {|x| [1,3,4].index x.alternative.question_id}
      .map(&:alternative)
      .map(&:number)
  end

  def to_datapoint
    data = self
      .picks
      .map(&:alternative)

    (1..5).map do |i|
      data.map {|x| x.question_id == i ? x.number : 0}.sum
    end
  end
end
