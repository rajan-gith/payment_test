class AddingWalletAmountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :wallet_amount, :float, default: 0
  end
end
