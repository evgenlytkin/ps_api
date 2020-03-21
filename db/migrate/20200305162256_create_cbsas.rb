# frozen_string_literal: true

class CreateCbsas < ActiveRecord::Migration[6.0]
  def change
    create_table :cbsas do |t|
      t.string :cbsa, limit: 5, null: false
      t.integer :statistical_area_id, null: true
      t.timestamps
    end

    add_index :cbsas, :cbsa
    add_index :cbsas, :statistical_area_id
  end
end
