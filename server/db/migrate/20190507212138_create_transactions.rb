class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer     :transaction_type
      t.string      :invoice_number
      t.date        :invoice_date
      t.decimal     :invoice_amount
      t.decimal     :balance
      t.string      :payment_receipt
      t.string      :payment_bank
      t.date        :payment_date
      t.decimal     :payment_amount
      t.boolean     :is_import
      t.belongs_to  :customer, index: true, foreign_key: true
      t.timestamps
    end
  end
end
