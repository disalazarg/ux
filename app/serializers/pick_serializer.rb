class PickSerializer < ActiveModel::Serializer
  attributes :id, :question_id, :alternative_id
end
