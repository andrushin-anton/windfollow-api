class CreateApiV1Gfs < ActiveRecord::Migration
  def change
    create_table :api_v1_gfs do |t|
      t.datetime :rt
      t.datetime :vt
      t.float :lat
      t.float :lon
      t.float :HGT_850
      t.float :TMP_850
      t.float :UGRD_850
      t.float :VGRD_850
      t.float :HGT_925
      t.float :TMP_925
      t.float :UGRD_925
      t.float :VGRD_925
      t.float :HGT_0
      t.float :TMP_2
      t.float :RH_2
      t.float :RH_925
      t.float :RH_850
      t.float :TMAX_2
      t.float :TMIN_2
      t.float :UGRD_0
      t.float :VGRD_0
      t.float :APCP_0
      t.float :ACPCP_0
      t.float :CSNOW_0
      t.float :LFTX_0
      t.float :CAPE_0
      t.float :TCDC_925
      t.float :TCDC_700
      t.float :TCDC_500
      t.float :TCDC_0
      t.float :DSWRF_0
      t.float :USWRF_0
      t.float :PRMSL_0
      t.float :GUST_0
      t.float :ULWRF_0
      t.float :DLWRF_0
      t.float :UGRD_10
      t.float :U_GWD_0
      t.float :TMP_10
      t.float :CPRAT_0
      t.float :TMP_0
      t.float :VGRD_10
      t.float :UGRD_1
      t.float :VGRD_1

      t.timestamps null: false
    end
  end
end
