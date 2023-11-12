# frozen_string_literal: true

module BasicPagination
  extend ActiveSupport::Concern

  PAGE_DEFAULT_SIZE = 25

  def page_number(params)
    params[:display_start].to_i / per_page(params) + 1
  end

  def per_page(params)
    params[:display_length].to_i.positive? ? params[:display_length].to_i : PAGE_DEFAULT_SIZE
  end
end