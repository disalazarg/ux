class PollSerializer < ActiveModel::Serializer
  attributes :id, :title, :finish, :intro, :slug
  has_one :product
end
