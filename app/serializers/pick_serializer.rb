class PickSerializer < ActiveModel::Serializer
  attributes :id
  has_one :answer
  has_one :alternative
end
