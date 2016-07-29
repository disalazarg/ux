class DistrictSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng, :slug
  has_one :province
end
