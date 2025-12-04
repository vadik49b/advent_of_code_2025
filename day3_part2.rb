packs = File.readlines('day3_input.txt', chomp: true)

total_output_joltage = packs.sum do |pack|
  nums = pack.split('').map(&:to_i)

  digits = []
  l = 0

  12.times do |i|
    r = nums.length - 12 + i
    segment = nums[l..r]

    max_val = segment.max
    max_pos = l + segment.index(max_val)

    digits << max_val
    l = max_pos + 1
  end

  digits.join('').to_i
end

puts "total_output_joltage=#{total_output_joltage}"
