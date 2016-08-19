class AnswerSerializer < ActiveModel::Serializer
  attributes :id
  has_one :contact
  has_one :product
end
