class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug
  has_one :district
  has_one :statute
  has_one :education
end
