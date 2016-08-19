class Answer < ActiveRecord::Base
  belongs_to :contact
  belongs_to :product
  has_many :picks, inverse_of: :answer

  accepts_nested_attributes_for :picks
end
