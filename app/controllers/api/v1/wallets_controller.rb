module Api::V1
  class WalletsController < ApiController
    def create
      if params
        @wallet = params
        render :show, status: 201
      else
        render json: { errors: 'No Transactions found' }, status: :unprocessable_entity
      end
    end

  end
end
