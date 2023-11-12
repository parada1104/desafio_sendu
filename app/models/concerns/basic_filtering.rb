# frozen_string_literal: true

module BasicFiltering
  extend ActiveSupport::Concern

  def basic_search_results(params, filter: true, paginate: true)
    results = all
    results = filter_results(params, results) if filter
    total_amount = results.size

    results = results.page(page_number(params)).per(per_page(params)) if paginate
    [results, total_amount]
  end

  def search_results(params, filter: true, paginate: true, blueprint_props: {}, serialize_records: true)
    results, total_amount = basic_search_results(params, filter: filter, paginate: paginate)
    return results unless serialize_records

    wrap_results(results, total_amount, blueprint_props)
  end

  def filter_results(params, results)
    self::FILTERING_OPTIONS.each do |filter_option, filter_method|
      next unless params[filter_option].present?
      next results = results.public_send(filter_method) if params[filter_option].eql?('present')

      results = results.public_send(filter_method, params[filter_option])
    end
    results
  end

  def wrap_results(results, amount, blueprint_props = {})
    blueprint = if blueprint_props[:name]
                  blueprint_props[:name].to_s.constantize
                else
                  "#{self}Blueprint".constantize
                end
    results = blueprint.render_as_hash(results, blueprint_props[:options] || {})
    {
      metadata: {
        amount: amount
      },
      data: results
    }
  end
end