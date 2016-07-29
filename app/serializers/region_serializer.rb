class RegionSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng, :slug
end
