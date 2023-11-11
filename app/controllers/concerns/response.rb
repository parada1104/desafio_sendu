# frozen_string_literal: true

module Response
  def json_response(object, status = :ok, include: '*', **args)
    render json: object, status: status, include: include, **args
  end
end
