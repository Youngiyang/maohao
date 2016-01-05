module V1
  module SharedParams
    extend Grape::API::Helpers

    params :mobile do
      requires :mobile, regexp: /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/
    end

    params :auth_code_type do
      requires :auth_code_type, values: ['sign_up', 'forget_password']
    end

    params :password do
      requires :password
    end

    params :auth_code do
      requires :auth_code
    end

    params :mobile_password do
      use :mobile, :password
    end

    params :location_params do
      requires :lnt
      requires :lng
      requires :distance
    end

    params :pagenate do
      optional :offset, type: Integer, default: 0
      optional :limit, type: Integer, default: 10
    end

    params :lntlng do
      requires :lnt, type: Float
      requires :lng, type: Float
    end
  end
end
