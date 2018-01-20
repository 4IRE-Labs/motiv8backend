module Api::V1
  class UptimeController < ApiController
    def show
      @data = {
        started_at: Time.now
      }
      render json: @data, status: 200
    end
  end
end
