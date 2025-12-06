input = File.readlines('day5_input.txt', chomp: true)

blank_line_index = input.index('')

fresh_id_ranges = input[0...blank_line_index].map { |r| r.split('-').map(&:to_i) }

fresh_ids_count = input[blank_line_index + 1..].sum do |id|
  is_fresh = fresh_id_ranges.any? do |r|
    id.to_i.between?(r[0], r[1])
  end

  is_fresh ? 1 : 0
end

puts "fresh_ids_count=#{fresh_ids_count}"
