class CreateBalances < ActiveRecord::Migration[5.1]
  def change
    create_table :balances do |t|
      t.decimal     :balance
      t.decimal     :past_due_balance
      t.date        :last_transaction_date
      t.integer     :type
      t.belongs_to  :customer, index: true, foreign_key: true
      t.timestamps
    end
  end
end
