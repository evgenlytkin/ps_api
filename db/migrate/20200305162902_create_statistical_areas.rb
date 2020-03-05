# frozen_string_literal: true

class CreateStatisticalAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :statistical_areas do |t|
      t.integer :cbsa_id, foreign_key: true
      t.string :name, limit: 150, null: false
      t.integer :popestimate_2014, null: false
      t.integer :popestimate_2015, null: false
      t.timestamps
    end

    add_foreign_key :statistical_areas, :cbsas
  end
end
