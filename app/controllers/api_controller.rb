require 'application_responder'

class ApiController < ActionController::API
  self.responder = ApplicationResponder
  respond_to :json
end
