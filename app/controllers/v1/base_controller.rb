class V1::BaseController < ApplicationController
  include SmsHelper
  include V1::SessionsHelper
  skip_before_action :verify_authenticity_token
end
