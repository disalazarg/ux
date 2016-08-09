class ContactSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :slug
  has_one :school
end
