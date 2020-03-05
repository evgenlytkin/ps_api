# frozen_string_literal: true

class CreateZipCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :zip_codes do |t|
      t.integer :zip_code, null: false
      t.timestamps
    end

    add_index :zip_codes, :zip_code
  end
end
