# frozen_string_literal: true

module Api
  class ApiController < ActionController::API
    include ActionController::MimeResponds
    include ExceptionHandler
    include Response
  end
end
