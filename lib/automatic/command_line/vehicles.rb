require 'thor'
require 'terminal-table'

require File.expand_path('../../client', __FILE__)

module Automatic
  module CommandLine
    class Vehicles < Thor
      desc 'all', 'List all Automatic Vehicles'
      def all
        puts "\n"

        vehicles = Automatic::Client::Vehicles.all

        if vehicles.any?
          vehicle_row = ->(index,record) do
            [index, record.id, record.year, record.make, record.model, record.color, record.display_name]
          end

          title    = "Automatic Vehicles"
          headings = ['#', 'ID', 'Year', 'Make', 'Model', 'Color', 'Display Name']
          rows     = vehicles.each_with_index.map { |record, index| vehicle_row.call((index + 1), record) }
          table    = Terminal::Table.new(title: title, headings: headings, rows: rows)

          puts table.to_s
        else
          puts "No Vehicles found."
        end
        puts "\n"
      end
    end
  end
end
