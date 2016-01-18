class BaseEntity < Grape::Entity
  format_with(:utc_time) { |t| t.to_i }

  def self.expose_qiniu_url(arg, options={})
    expose arg, options do |obj|
      attr = obj.send(arg)
      if attr.present?
        if attr.respond_to?(:to_ary)
          attr.map {|x| Rails.application.config.qiniu_domain + x}
        else
          Rails.application.config.qiniu_domain + attr
        end
      end
    end
  end

  def self.expose_timestamp(*args, &block)
    with_options(format_with: :utc_time) do
      expose *args, &block
    end
  end
end
