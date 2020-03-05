# frozen_string_literal: true

class CreateCbsas < ActiveRecord::Migration[6.0]
  def change
    create_table :cbsas do |t|
      t.string :cbsa, limit: 5, null: false
      t.timestamps
    end

    add_index :cbsas, :cbsa
  end
end
