class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.string :address
      t.string :title
      t.string :description
      t.integer :reward_type

      t.timestamps
    end
  end
end