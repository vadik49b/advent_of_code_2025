id_ranges = File.read('day2_input.txt').strip.split(',')

invalid_ids_sum = 0

id_ranges.each do |id_range|
  first_id, last_id = id_range.split('-').map(&:to_i)

  (first_id..last_id).map do |id|
    is_invalid = (1..id.to_s.length / 2).any? do |i|
      id.to_s.match?(/^(#{id.to_s[0, i]}){2,}$/)
    end

    invalid_ids_sum += id if is_invalid
  end

end

puts "Invalid ids sum: #{invalid_ids_sum}"
