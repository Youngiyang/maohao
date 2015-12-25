module V1
  class SuperDevApi < Grape::API
    helpers V1::SharedParams


    namespace 'super_dev' do
      params do
        use :mobile_password
      end
      delete 'user' do
        user = User.find_by(mobile: params[:mobile])
        if user
          if user.authenticate(params[:password])
            user.destroy
          else
            bad_request!('密码错误,你妹！')
          end
        else
          bad_request!('没注册还要删！你他妈逗我呢！')
        end
      end
    end
  end
end
