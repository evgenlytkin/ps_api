# frozen_string_literal: true

class CreateStatisticalAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :statistical_areas do |t|
      t.string :cbsa, limit: 5, null: false
      t.string :mdiv, limit: 5, null: true
      t.string :name, limit: 50, null: false
      t.string :lsad, limit: 50, null: false
      t.integer :popestimate_2014, null: false
      t.integer :popestimate_2015, null: false
      t.timestamps
    end

    add_index :statistical_areas, :cbsa
  end
end
