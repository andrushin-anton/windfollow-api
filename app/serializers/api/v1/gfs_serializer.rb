class Api::V1::GfsSerializer < ActiveModel::Serializer
  attributes :rt, :vt, :lat, :lon, :GUST_0, :UGRD_10, :TMP_10, :CPRAT_0, :TMP_0, :VGRD_10, :UGRD_1, :VGRD_1
end