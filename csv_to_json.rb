#!/usr/bin/env ruby
require 'csv'
require 'json'
require 'digest'

lines = CSV.open(ARGV[0]).readlines
keys = lines.delete lines.first
keys.insert(0, '_id')
keys.insert(1, 'service_id')

File.open(ARGV[1], 'w') do |f|
  data = lines.each_with_index.map do |row, index|
    i = index + 1
    # Inserts _id
    row.insert(0, i)
    # Inserts service_id
    row.insert(1, Digest::SHA256.hexdigest(row[1]))
    Hash[keys.zip(row)]
  end

  f.puts JSON.pretty_generate("data": data)
end
