# frozen_string_literal: true

class CreateZipCodeCbsas < ActiveRecord::Migration[6.0]
  def change
    create_table :zip_code_cbsas do |t|
      t.references :zip_code, foreign_key: true
      t.references :cbsa, foreign_key: true

      t.timestamps
    end
  end
end
