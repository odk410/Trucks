# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Company.create(name: '없을무회사')
Group.create(name: '없을무그룹', company: Company.find(1), num_member: 1)
Celebrity.create(name: '주이', company: Company.find(1), group: Group.find(1), category:"가수/아이돌", color:"모름")
User.create(email: "qwe@qwe", password: "qweqwe", password_confirmation: "qweqwe", tel:"qweqwe", name: "qweqwe", addr:"qweqwe", postcode: "qweqwe")

# 유저가 셀럽에게 송금한 기록, balance는 acc_num의 잔고
# rails g model Transaction account:references amount:integer balance:integer remit:boolean receive:boolean target

Transaction.create(account: User.last.account, amount: 10000, balance: 0, remit: true, receive: false, target: Celebrity.last.account.acc_num)
Transaction.create(account: Celebrity.last.account,
                  target: User.last.account.acc_num,
                  amount: 10000,
                  balance: 10000,
                  remit: false,
                  receive: true)

Celebrity.last.account.update(balance: 10000)
