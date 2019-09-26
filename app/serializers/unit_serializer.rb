class UnitSerializer < ActiveModel::Serializer
  attributes :id, :apt_num, :tenant

  belongs_to :building
  belongs_to :user
end
