# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_json_api(resource, options = {})
    render options.merge(json: resource || {})
  end

  def render_errors(resource)
    render_json_api(resource.errors, status: :unprocessable_entity)
  end
end
