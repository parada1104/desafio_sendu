# frozen_string_literal: true

module Request
  module JsonHelper
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end
end

