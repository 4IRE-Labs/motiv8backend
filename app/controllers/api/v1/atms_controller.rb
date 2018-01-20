module Api::V1
  class AtmsController < ApiController
    before_action :set_atm, only: %i[deposit withdraw]

    def create
      @atm = Atm.new(atm_params)
      if @atm.save
        render :show, status: 201
      else
        render json: { errors: @atm.errors }, status: :unprocessable_entity
      end
    end

    def deposit
      command = AddTransactionToAtm.call(@atm, banknote_params, :deposit)
      if command.success?
        @deposit = command.result
        render json: @deposit, status: 201
      else
        render json: { errors: command.errors }, status: :unprocessable_entity
      end
    end

    def withdraw
      command = WithdrawFromAtm.call(@atm, params[:amount])
      if command.success?
        @amount = command.result
        render json: @amount, status: 200
      else
        render json: { errors: command.errors }, status: :unprocessable_entity
      end
    end

    private

    def set_atm
      @atm = Atm.find(params[:id])
    end

    def atm_params
      params.require(:atm).permit(:name, banknotes_attributes:[:value])
    end

    def banknote_params
      params.require(:banknote)
    end
  end
end
