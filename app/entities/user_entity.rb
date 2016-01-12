class UserEntity < BaseEntity
  root 'users'

  expose :id, :nick_name, :mobile, :sex, :residence
  expose_qiniu_url :avatar
end
