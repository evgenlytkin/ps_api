# frozen_string_literal: true

namespace :import do
  desc 'Import CSV files'

  task csv: :environment do
    require 'csv'
    # should be moved out from the repo and stored a on file storage
    # then we can add a class to fetch csv files and save them in a tmp folder

    zip_to_cbsa_file = Rails.root.join('zip_to_cbsa.csv')
    cbsa_to_msa_file = Rails.root.join('cbsa_to_msa.csv')

    CsvParserService.perform(zip_to_cbsa_file, cbsa_to_msa_file)
  end
end
