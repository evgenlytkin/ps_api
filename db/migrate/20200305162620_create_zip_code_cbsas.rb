# frozen_string_literal: true

class CreateZipCodeCbsas < ActiveRecord::Migration[6.0]
  def change
    create_table :zip_code_cbsas do |t|
      t.integer :zip_code_id, foreign_key: true
      t.integer :cbsa_id, foreign_key: true

      t.timestamps
    end

    add_foreign_key :zip_code_cbsas, :zip_codes
    add_foreign_key :zip_code_cbsas, :cbsas
  end
end
