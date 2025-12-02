id_ranges = File.read('day2_input.txt').strip.split(',')

invalid_ids_sum = 0

id_ranges.each do |id_range|
  first_id, last_id = id_range.split('-').map(&:to_i)

  (first_id..last_id).map do |id|
    id_length = id.to_s.length

    if id_length.even? && id.to_s[0, id_length / 2] == id.to_s[id_length / 2, id_length]
      invalid_ids_sum += id
    end
  end
end

puts "Invalid ids sum: #{invalid_ids_sum}"
