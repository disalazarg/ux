class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :link, :description, :slug
  has_one :user
end
