class V1::BaseController < ApplicationController
  include SmsHelper
  include V1::SessionsHelper
  skip_before_action :verify_authenticity_token

  QINIU_DOMAIN = 'http://7xp731.com1.z0.glb.clouddn.com/'

  private
    def uptoken

      put_policy = Qiniu::Auth::PutPolicy.new(
        "playmall"     # 存储空间
        # key,        # 最终资源名，可省略，即缺省为“创建”语义
        # expires_in, # 相对有效期，可省略，缺省为3600秒后 uptoken 过期
        # deadline    # 绝对有效期，可省略，指明 uptoken 过期期限（绝对值），通常用于调试
      )

      uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    end
end
