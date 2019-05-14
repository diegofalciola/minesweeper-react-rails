module Api
  module V1
    class BalancesController < ApiController
      def index
        balances = Balance.includes(:customer)

        render json: balances
      end
    end
  end
end
