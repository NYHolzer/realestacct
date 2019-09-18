class UnitSerializer < ActiveModel::Serializer
  attributes :id, :apt_num, :tenant

  belongs_to :building
end
