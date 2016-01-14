class AddFieldsToUsers < ActiveRecord::Migration
 
  
  def up
    add_column :users, :first_name, :string, null: false, default: ""
    change_column_null :users, :first_name, false
    add_column :users, :last_name, :string, null: false, default: ""
    change_column_null :users, :last_name, false
    add_column :users, :state, :string, null: false, default: ""
    change_column_null :users, :state, false
    add_column :users, :city, :string, null: false, default: ""
    change_column_null :users, :city, false
    add_column :users, :address, :string, null: false, default: ""
    change_column_null :users, :address, false
    add_column :users, :email, :string, null: false, default: ""
    change_column_null :users, :email, false
    add_column :users, :phone, :string, null: false, default: ""
    change_column_null :users, :phone, false
  end
  def down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :state, :string
    remove_column :users, :city, :string
    remove_column :users, :address, :string
    remove_column :users, :email, :string
    remove_column :users, :phone, :string
  end
  
end