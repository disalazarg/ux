class Question < ActiveRecord::Base
  belongs_to :poll
  has_many :alternatives, inverse_of: :question
end
