# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
test = User.create(nick_name: "yzq", password: "123456", mobile: "13128980333", email: "yzq@163.com")
test2 = Admin.create(name: "cyy", password: "123456", email: "cyy@163.com")

