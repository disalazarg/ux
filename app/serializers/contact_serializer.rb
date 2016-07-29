class ContactSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :rbd, :slug
  has_one :school
end
