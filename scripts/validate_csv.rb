#!/usr/bin/env ruby

require 'csv'

# read headers
csv = CSV.read(ARGV[0], headers: true)

cumul_fields = csv.headers.select{ |h| h =~ /^ncumul_/ }

last = {}

csv.each_with_index do |row, idx|
  # check if this canton was seen before
  if last[row[2]]
    cumul_fields.each do |col|
      if row[col].to_i < last[row[2]][col].to_i
        abort "Error on line #{idx}, canton #{row[2]}, field #{col}: #{row[col].to_i} < #{last[row[2]][col].to_i}"
      end
    end
  end

  # update last state of the canton
  last[row[2]] = row
end


