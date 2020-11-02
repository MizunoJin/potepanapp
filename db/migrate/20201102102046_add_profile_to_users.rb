class AddProfileToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :website, :string
    add_column :users, :introduction, :text
    add_column :users, :number, :string
    add_column :users, :sex, :string
  end
end
