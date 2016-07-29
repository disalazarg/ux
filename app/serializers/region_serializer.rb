class RegionSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :lat, :lng, :slug
end
