require 'qiniu'

Qiniu.establish_connection! :access_key => 'Uu3lFFZPwE7jBd2PZB_OJsHjRkSpeFcKlIuKqw-0',
                            :secret_key => 'iJCgBx6O9T36E8ufyqRONUJ6XTel2Uu7C3gzB7AH'
                            
put_policy = Qiniu::Auth::PutPolicy.new('playmall')

uptoken = Qiniu::Auth.generate_uptoken(put_policy)

code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
    put_policy,     # 上传策略
    local_file     # 本地文件名
)

primitive_url = 'http://7xp731.com1.z0.glb.clouddn.com/a/b/c.htm'
download_url = Qiniu::Auth.authorize_download_url(primitive_url)