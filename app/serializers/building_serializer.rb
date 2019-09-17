class BuildingSerializer < ActiveModel::Serializer
  attributes :id, :name, :address1, :address2, :city, :state, :zip_code

  has_many :units
end
