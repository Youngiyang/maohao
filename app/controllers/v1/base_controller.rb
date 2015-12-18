class V1::BaseController < ApplicationController
  include SmsHelper
  include V1::SessionsHelper
  include V1::QiniuHelper
  skip_before_action :verify_authenticity_token
end
