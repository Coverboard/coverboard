class Api::BaseController < ActionController::Base
  protect_from_forgery with: :null_session

  protected
    def json_response(status, payload = [])
      render json: {
                 status: status,
                 payload: payload
             }
    end
end
