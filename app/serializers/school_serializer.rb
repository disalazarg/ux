class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :statute, :slug
  has_one :district
end
