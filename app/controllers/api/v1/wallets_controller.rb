module Api::V1
  class WalletsController < ApiController
    before_action :set_wallet, only: [:show]

    def create
      @wallet = Wallet.new(wallet_params)
      if @wallet.save
        render :show, status: 201
      else
        render json: { errors: 'Creation Error' }, status: :unprocessable_entity
      end
    end

    def show; end

    def check_donation
      
      if params
        @donation = params
        render :check_donation, status: 200
      else
        render json: { errors: 'No Transactions made' }, status: :unprocessable_entity
      end
    end

    private

    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    def wallet_params
      params.require(:wallet).permit(:address, :title, :description, :reward_type)
    end

  end
end
