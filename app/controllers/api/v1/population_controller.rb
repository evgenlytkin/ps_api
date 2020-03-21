# frozen_string_literal: true

module Api
  module V1
    class PopulationController < ApplicationController
      before_action :statistic_response, only: [:index]

      def index
        if @zip_code.valid?
          render_json_api(@zip_code, status: :ok)
        else
          render_errors(@zip_code)
        end
      end

      private

      def statistic_response
        @zip_code = ZipCode.find_or_initialize_by(zip_code: valid_params)
      end

      def valid_params
        params.require(:zip)
      end
    end
  end
end
