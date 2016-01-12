Rails.application.routes.draw do
  mount V1::API => '/v1'
end
