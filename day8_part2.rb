boxes = File.readlines('day8_input.txt', chomp: true).map { |l| l.split(',').map(&:to_i) }

N = boxes.length

network = Array.new(N) { Array.new(N) }

(0...N).to_a.combination(2).each do |i, j|
  xi, yi, zi = boxes[i]
  xj, yj, zj = boxes[j]
  d = Math.sqrt((xi - xj)**2 + (yi - yj)**2 + (zi - zj)**2)
  network[i][j] = network[j][i] = d
end

circuits = Array.new(N) { Array.new(N, 0) }
circuits_pow = Array.new(N) { |i| Set[i] }
connections = []

while circuits_pow.length > 1
  min_dist = Float::INFINITY
  min_i = nil
  min_j = nil

  (0...N).each do |i|
    (0...N).each do |j|
      if network[i][j].nil?
        circuits[i][j] = 1
        next
      end

      dist = network[i][j]
      if dist < min_dist && circuits[i][j].zero?
        min_dist = dist
        min_i = i
        min_j = j
      end
    end
  end

  puts "connecting #{boxes[min_i]} and #{boxes[min_j]}, dist=#{min_dist}"

  circuits[min_i][min_j] = circuits[min_j][min_i] = 1
  connections << [boxes[min_i], boxes[min_j]]

  merged = circuits_pow
           .select { |c| c.include?(min_i) || c.include?(min_j) }
           .reduce(Set.new, :merge)

  circuits_pow = circuits_pow
                 .reject { |c| c.include?(min_i) || c.include?(min_j) } << merged

  puts "circuits_pow.length = #{circuits_pow.length}"
end

b0, b1 = connections.last
puts "x0 * x1 = #{b0[0] * b1[0]}"
