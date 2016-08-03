class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :statement
  has_one :poll
end
