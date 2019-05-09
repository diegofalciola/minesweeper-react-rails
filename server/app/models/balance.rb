class Balance < ApplicationRecord
  before_create do
    self.calculate_balance
  end

  def calculate_balance
    puts "calculating balance"
  end
end
