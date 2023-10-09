class ErrorsController < ApplicationController
    # def not_found
    #   render_error(404, "Not Found")
    # end
  
    # def unprocessable_entity
    #   render_error(422, "Unprocessable Entity")
    # end
  
    # def internal_server_error
    #   render_error(500, "Internal Server Error")
    # end
  
    # private
  
    # def render_error(status, message)
    #   @status = status
    #   @message = message
    #   render status: status, template: "public/error"
    # end

    def not_found
        # render json: {
        #   status: 404,
        #   error: :not_found,
        #   message: 'Where did the 403 errors go'
        # }, status: 404
        render status: status, template: "errors/404"
      end
    
      # def internal_server_error
      #   # debugger
      #   render json: {
      #     status: 500,
      #     error: :internal_server_error,
      #     message: 'Houston we have a problem'
      #   }, status: 500
      # end
  end
  