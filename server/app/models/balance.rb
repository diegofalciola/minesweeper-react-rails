class Balance < ApplicationRecord
  require 'date'

  before_create do
    self.calculate_balance
  end

  def calculate_balance
    self.white_balance = Transaction
                             .where(:customer_id => self.customer_id)
                             .where(:transaction_type => 0)
                             .pluck("COALESCE(SUM(invoice_amount),0) + COALESCE(SUM(payment_amount),0)*-1")[0]

    self.black_balance = Transaction
                             .where(:customer_id => self.customer_id)
                             .where(:transaction_type => 1)
                             .pluck("COALESCE(SUM(invoice_amount),0) + COALESCE(SUM(payment_amount),0)*-1")[0]
  end
end

