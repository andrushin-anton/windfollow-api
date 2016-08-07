require 'test_helper'

class Api::V1::GFsControllerTest < ActionController::TestCase
  setup do
    @api_v1_gf = api_v1_gfs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_gfs)
  end

  test "should create api_v1_gf" do
    assert_difference('Api::V1::Gfs.count') do
      post :create, api_v1_gf: { ACPCP_0: @api_v1_gf.ACPCP_0, APCP_0: @api_v1_gf.APCP_0, CAPE_0: @api_v1_gf.CAPE_0, CPRAT_0: @api_v1_gf.CPRAT_0, CSNOW_0: @api_v1_gf.CSNOW_0, DLWRF_0: @api_v1_gf.DLWRF_0, DSWRF_0: @api_v1_gf.DSWRF_0, GUST_0: @api_v1_gf.GUST_0, HGT_0: @api_v1_gf.HGT_0, HGT_850: @api_v1_gf.HGT_850, HGT_925: @api_v1_gf.HGT_925, LFTX_0: @api_v1_gf.LFTX_0, PRMSL_0: @api_v1_gf.PRMSL_0, RH_2: @api_v1_gf.RH_2, RH_850: @api_v1_gf.RH_850, RH_925: @api_v1_gf.RH_925, TCDC_0: @api_v1_gf.TCDC_0, TCDC_500: @api_v1_gf.TCDC_500, TCDC_700: @api_v1_gf.TCDC_700, TCDC_925: @api_v1_gf.TCDC_925, TMAX_2: @api_v1_gf.TMAX_2, TMIN_2: @api_v1_gf.TMIN_2, TMP_0: @api_v1_gf.TMP_0, TMP_10: @api_v1_gf.TMP_10, TMP_2: @api_v1_gf.TMP_2, TMP_850: @api_v1_gf.TMP_850, TMP_925: @api_v1_gf.TMP_925, UGRD_0: @api_v1_gf.UGRD_0, UGRD_10: @api_v1_gf.UGRD_10, UGRD_1: @api_v1_gf.UGRD_1, UGRD_850: @api_v1_gf.UGRD_850, UGRD_925: @api_v1_gf.UGRD_925, ULWRF_0: @api_v1_gf.ULWRF_0, USWRF_0: @api_v1_gf.USWRF_0, U_GWD_0: @api_v1_gf.U_GWD_0, VGRD_0: @api_v1_gf.VGRD_0, VGRD_10: @api_v1_gf.VGRD_10, VGRD_1: @api_v1_gf.VGRD_1, VGRD_850: @api_v1_gf.VGRD_850, VGRD_925: @api_v1_gf.VGRD_925, lat: @api_v1_gf.lat, lon: @api_v1_gf.lon, rt: @api_v1_gf.rt, vt: @api_v1_gf.vt }
    end

    assert_response 201
  end

  test "should show api_v1_gf" do
    get :show, id: @api_v1_gf
    assert_response :success
  end

  test "should update api_v1_gf" do
    put :update, id: @api_v1_gf, api_v1_gf: { ACPCP_0: @api_v1_gf.ACPCP_0, APCP_0: @api_v1_gf.APCP_0, CAPE_0: @api_v1_gf.CAPE_0, CPRAT_0: @api_v1_gf.CPRAT_0, CSNOW_0: @api_v1_gf.CSNOW_0, DLWRF_0: @api_v1_gf.DLWRF_0, DSWRF_0: @api_v1_gf.DSWRF_0, GUST_0: @api_v1_gf.GUST_0, HGT_0: @api_v1_gf.HGT_0, HGT_850: @api_v1_gf.HGT_850, HGT_925: @api_v1_gf.HGT_925, LFTX_0: @api_v1_gf.LFTX_0, PRMSL_0: @api_v1_gf.PRMSL_0, RH_2: @api_v1_gf.RH_2, RH_850: @api_v1_gf.RH_850, RH_925: @api_v1_gf.RH_925, TCDC_0: @api_v1_gf.TCDC_0, TCDC_500: @api_v1_gf.TCDC_500, TCDC_700: @api_v1_gf.TCDC_700, TCDC_925: @api_v1_gf.TCDC_925, TMAX_2: @api_v1_gf.TMAX_2, TMIN_2: @api_v1_gf.TMIN_2, TMP_0: @api_v1_gf.TMP_0, TMP_10: @api_v1_gf.TMP_10, TMP_2: @api_v1_gf.TMP_2, TMP_850: @api_v1_gf.TMP_850, TMP_925: @api_v1_gf.TMP_925, UGRD_0: @api_v1_gf.UGRD_0, UGRD_10: @api_v1_gf.UGRD_10, UGRD_1: @api_v1_gf.UGRD_1, UGRD_850: @api_v1_gf.UGRD_850, UGRD_925: @api_v1_gf.UGRD_925, ULWRF_0: @api_v1_gf.ULWRF_0, USWRF_0: @api_v1_gf.USWRF_0, U_GWD_0: @api_v1_gf.U_GWD_0, VGRD_0: @api_v1_gf.VGRD_0, VGRD_10: @api_v1_gf.VGRD_10, VGRD_1: @api_v1_gf.VGRD_1, VGRD_850: @api_v1_gf.VGRD_850, VGRD_925: @api_v1_gf.VGRD_925, lat: @api_v1_gf.lat, lon: @api_v1_gf.lon, rt: @api_v1_gf.rt, vt: @api_v1_gf.vt }
    assert_response 204
  end

  test "should destroy api_v1_gf" do
    assert_difference('Api::V1::Gfs.count', -1) do
      delete :destroy, id: @api_v1_gf
    end

    assert_response 204
  end
end
