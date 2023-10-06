module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        # rescue_from ActiveRecord::RecordNotFound do |e|
          # respond(:record_not_found, 404, e.to_s)
        # end
        # rescue_from CustomError do |e|
          # debugger
          # respond(e.error, e.status, e.message.to_s)
        # end
        # debugger
        rescue_from StandardError do |e|
          # debugger
          # respond(:standard_error, 500, e.to_s)
          render status: status, template: "errors/500"

        end
      end
    end

    private

    # def respond(_error, _status, _message)
      # json = Helpers::Render.json(_error, _status, _message)
      # render json: json, status: _status
    # end
  end
end
