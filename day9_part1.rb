coordinates = File.readlines('day9_input.txt', chomp: true).map { |l| l.split(',').map(&:to_i) }

areas = []

(0...coordinates.length).each do |i|
  (i + 1...coordinates.length).each do |j|
    xi, yi = coordinates[i]
    xj, yj = coordinates[j]
    area = ((xi - xj).abs + 1) * ((yi - yj).abs + 1)
    areas << [area, i, j]
  end
end

areas.sort!

puts "largest_area=#{areas.last[0]}"
