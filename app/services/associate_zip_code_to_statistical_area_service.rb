# frozen_string_literal: true

class AssociateZipCodeToStatisticalAreaService < ServiceObject
  def perform!
    ZipCode.valid_zip_codes.find_each do |zip_code|
      associate_zip_code_to_statistical_area(zip_code, zip_code.cbsa.cbsa)
    end
  end

  private

  def associate_zip_code_to_statistical_area(zip_code, cbsa_value)
    ActiveRecord::Base.connection.execute(
      <<~SQL
        WITH cte_result AS (
          select cbsa
          from statistical_areas
          where (cbsa = '#{cbsa_value}') OR (mdiv = '#{cbsa_value}')
          GROUP BY CBSA
        )
        UPDATE cbsas SET statistical_area_id = (
          SELECT statistical_areas.id
          FROM cte_result
          JOIN statistical_areas on statistical_areas.cbsa = cte_result.cbsa
          WHERE lsad = 'Metropolitan Statistical Area'
        )
        FROM zip_codes WHERE zip_codes.cbsa_id = cbsas.id AND zip_codes.id = #{zip_code.id}
    SQL
    )
  end
end
