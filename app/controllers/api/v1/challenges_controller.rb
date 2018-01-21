module Api::V1
  class ChallengesController < ApiController
    before_action :set_challenge, only: [:claim_one_badge]

    def claim_one_badge
      MyOwn.new.claim_one_badge(@challenge, challenge_params[:user_address])
      render :claim_one_badge, status: 201
    end

    private

    def set_challenge
      @challenge = Wallet.find(params[:id])
    end

    def challenge_params
      params.require(:challenge).permit(:user_address)
    end

  end
end
