packs = File.readlines('day3_input.txt', chomp: true)

total_output_joltage = packs.sum do |pack|
  nums = pack.split('').map(&:to_i)

  l0, l1 = nums

  (1..nums.length - 2).each do |i|
    n = nums[i]
    if n > l0
      l0 = n
      l1 = nums[i + 1]
    elsif n > l1
      l1 = n
    end
  end

  l1 = nums.last if nums.last > l1

  "#{l0}#{l1}".to_i
end

puts "total_output_joltage=#{total_output_joltage}"
