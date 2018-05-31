class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.create_account(type, id)
    @account = Account.new(acc_num: g_serial,
      master_type: type,
      master_id: id,
      balance: 0)
    @account.save

    puts "/"*50
    puts @account.master_type
    puts @account.master_id
    puts "/"*50
  end

  def self.g_serial
    random_str = ('a'..'z').to_a.shuffle[0,14].join
  end
end
