class ProvinceSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng, :slug
  has_one :region
end
