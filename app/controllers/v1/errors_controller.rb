class V1::ErrorsController < V1::BaseController
  def index
    render json: api_return(false, "102")
  end
end
