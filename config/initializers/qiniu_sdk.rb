#!/usr/bin/env ruby
require 'qiniu'

Qiniu.establish_connection! :access_key => 'Uu3lFFZPwE7jBd2PZB_OJsHjRkSpeFcKlIuKqw-0',
                            :secret_key => 'iJCgBx6O9T36E8ufyqRONUJ6XTel2Uu7C3gzB7AH'
Rails.application.config.qiniu_domain = 'http://7xp731.com1.z0.glb.clouddn.com/'
