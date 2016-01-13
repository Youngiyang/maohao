#!/usr/bin/env ruby
require 'qiniu'

if Rails.env != 'production'
  Qiniu.establish_connection! :access_key => 'Uu3lFFZPwE7jBd2PZB_OJsHjRkSpeFcKlIuKqw-0',
                              :secret_key => 'iJCgBx6O9T36E8ufyqRONUJ6XTel2Uu7C3gzB7AH'
  Rails.application.config.qiniu_domain = 'http://7xp731.com1.z0.glb.clouddn.com/'
else
  Qiniu.establish_connection! :access_key => 'niWDEnVg1cL9R1hkR3riNbsoK_jl8xe0VM64rV2a',
                              :secret_key => 'AgUoRB2itpXNL-tE-hW4OCuPldnbMav-SyGhiE6Q'
  Rails.application.config.qiniu_domain = 'http://7xq1w1.com1.z0.glb.clouddn.com/'
end
