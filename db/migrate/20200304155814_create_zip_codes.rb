# frozen_string_literal: true

class CreateZipCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :zip_codes do |t|
      t.string :zip_code, limit: 5, null: false
      t.integer :cbsa_id
      t.timestamps
    end

    add_index :zip_codes, :zip_code
    add_index :zip_codes, :cbsa_id
  end
end
