class V1::ErrorsController < ApplicationController
  def index
    render json: api_return(false, "102")
  end
end
