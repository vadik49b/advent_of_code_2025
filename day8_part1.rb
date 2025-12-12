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

1000.times do
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

  merged = circuits_pow
           .select { |c| c.include?(min_i) || c.include?(min_j) }
           .reduce(Set.new, :merge)

  circuits_pow = circuits_pow
                 .reject { |c| c.include?(min_i) || c.include?(min_j) } << merged
end

pp circuits_pow

max_circuits = circuits_pow.map(&:size).sort.reverse.first(3)
pp max_circuits
pp max_circuits.reduce(:*)
