class Balance < ApplicationRecord
  require 'date'

  before_create do
    self.calculate_balance
  end

  def calculate_balance
    # self.past_due_balance = Transaction
    #                             .where("transaction_date > ?", Date.today - 30)
    #                             .where(:customer_id => self.customer_id)
    #                             .sum(:amount)

    bills_total = Transaction
                    .where("transaction_date > ?", Date.today - 30)
                    .where(:customer_id => self.customer_id)
                    .sum(:amount)

  end
end
