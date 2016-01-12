class AppBannerEntity < BaseEntity
  expose :title, :url, :jump_type
  expose_qiniu_url :image
end
