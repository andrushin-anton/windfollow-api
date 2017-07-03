class Api::V1::GfsSerializer < ActiveModel::Serializer
  attributes :rt, :vt, :lat, :lon, :wind_dir, :wind_dir_deg, :wind_speed, :temp, :GUST_0, :CPRAT_0, :UGRD_1, :VGRD_1, :TCDC_925, :TCDC_700, :TCDC_500, :APCP_0, :precipitation
end