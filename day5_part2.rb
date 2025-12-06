input = File.readlines('day5_input.txt', chomp: true)

blank_line_index = input.index('')

fresh_id_ranges = input[0...blank_line_index].map { |r| r.split('-').map(&:to_i) }

merged_fresh_id_ranges = []

def insert_range(arr, r)
  overlap_index = arr.index do |rr|
    r[0] <= rr[1] && r[1] >= rr[0]
  end

  return arr << r unless overlap_index

  rr = arr[overlap_index]
  new_rr = [[r[0], rr[0]].min, [r[1], rr[1]].max]
  arr.delete_at(overlap_index)

  insert_range(arr, new_rr)
end

fresh_id_ranges.each do |r|
  insert_range(merged_fresh_id_ranges, r)
end

fresh_ids_count = merged_fresh_id_ranges.sum do |r|
  r[1] - r[0] + 1
end

puts "fresh_ids_count=#{fresh_ids_count}"
