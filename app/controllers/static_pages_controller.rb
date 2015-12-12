class StaticPagesController < ApplicationController
  def index
    render layout: 'static_pages'
  end
end
