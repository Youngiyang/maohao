class V1::BaseController < ApplicationController
  include SmsHelper
  skip_before_action :verify_authenticity_token
end
