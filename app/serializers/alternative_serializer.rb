class AlternativeSerializer < ActiveModel::Serializer
  attributes :id, :number, :statement
  has_one :question
end
