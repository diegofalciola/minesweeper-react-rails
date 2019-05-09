class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.date        :date
      t.integer     :transaction_type
      t.string      :invoice_number
      t.string      :receipt
      t.string      :bank
      t.date        :receipt_date
      t.decimal     :amount
      t.decimal     :payment_amount
      t.decimal     :payment_amount2
      t.decimal     :balance
      t.boolean     :is_import
      t.belongs_to  :customer, index: true, foreign_key: true
      t.timestamps
    end
  end
end
