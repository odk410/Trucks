class AddInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tel, :string, null: false, default: "", limit: 15
    add_column :users, :name, :string, default: "", limit: 20
    add_column :users, :addr, :text, default: "", limit: 100
    add_column :users, :postcode, :string, default: "", limit: 15
    add_column :users, :profile_img, :string
    add_column :users, :verified, :boolean, default: false
    add_column :users, :celeb_verified, :boolean, default: false
  end
end
