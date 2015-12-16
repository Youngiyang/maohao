class Officialsite::WebsiteController < ApplicationController
  def index
    render layout: 'officialsite/pages'
  end
end
