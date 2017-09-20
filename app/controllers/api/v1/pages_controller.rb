class Api::V1::PagesController < ApplicationController
  before_filter :authenticate_user!

  # GET /api/v1/pages/privacy
  # GET /api/v1/pages/privacy.json
  def privacy
    @api_v1_pages = Api::V1::Page.where('title = "privacy"').first

    render json: @api_v1_pages
  end

  # GET /api/v1/pages/terms
  # GET /api/v1/pages/terms.json
  def terms
    @api_v1_pages = Api::V1::Page.where('title = "terms"').first

    render json: @api_v1_pages
  end

end
