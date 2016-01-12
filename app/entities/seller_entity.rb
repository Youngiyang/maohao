class SellerEntity < UserEntity
  root 'sellers'

  expose :birthday, :is_seller, :credit_value, :real_name, :identify_sn
end
