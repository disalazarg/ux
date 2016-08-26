class Answer < ActiveRecord::Base
  belongs_to :contact
  belongs_to :product
  has_many :picks, inverse_of: :answer

  accepts_nested_attributes_for :picks

  validate :all_picked

  def all_picked
    unless picks.length == 5 then
      errors.add :picks, "Todas las alternativas deben ser respondidas"
    end
  end
end
