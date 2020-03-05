# frozen_string_literal: true

class CreateCbsas < ActiveRecord::Migration[6.0]
  def change
    create_table :cbsas do |t|
      t.integer :cbsa, null: false
      t.timestamps
    end

    add_index :cbsas, :cbsa
  end
end
