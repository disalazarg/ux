class Question < ActiveRecord::Base
  belongs_to :poll
  has_many :alternatives, inverse_of: :question

  delegate :to_s, to: :statement
end
