# PlayMall API

## Error handle

```ruby
  api_return status, code, hash={}
```
我们一般用这个函数做API json 返回函数。

```ruby
  status: 返回值状态，true为正确请求，false为非正确请求。
  code: 返回值代码，000为正确，非000为错误，代码用数字代表，三位数为系统级错误，四位为业务级错误。
  hash: 可选，用于需要返回数据的时候，会将此hash作为data返回。
```
所以我们一般情况下，api返回值只需要写成  

```ruby
  render json: api_return(status, code, return_hash)
```
当然，我们需要给错误代码提供一个解释，在错误的时候会将这些说明信息返回。这个我们需要在/config/locales/zh.yml文件中配置，如

```ruby
zh:
  error:
    "000": '成功'
    
    '0001': '用户登录名错误'
```
如果需要，按序添加在后边就可以。