class Answer < ActiveRecord::Base
  belongs_to :contact
  belongs_to :product
  has_many :picks, inverse_of: :answer
  has_many :alternatives, through: :picks

  accepts_nested_attributes_for :picks

  validate :all_picked

  scope :external, -> { where.not(contact: nil) }

  def all_picked
    if contact and picks.length < 5 then
      errors.add :picks, "Todas las alternativas deben ser respondidas"
    end
  end
end
