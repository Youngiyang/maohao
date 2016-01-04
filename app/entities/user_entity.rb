class UserEntity < Grape::Entity
  root 'users'

  expose :id, :nick_name, :mobile, :sex, :residence, :avatar

  private
    def avatar
      if object.avatar
        Rails.application.config.qiniu_domain + object.avatar
      end
    end
end
