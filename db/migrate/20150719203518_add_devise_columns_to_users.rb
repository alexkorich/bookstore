class AddDeviseColumnsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      # if you already have a email column, you have to comment the below line and add the :encrypted_password column manually (see devise/schema.rb).
      t.database_authenticatable
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.token_authenticatable
      t.timestamps
    end
  end
end