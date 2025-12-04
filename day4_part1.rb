grid = File.readlines('day4_input.txt', chomp: true).map { |l| l.split('') }

x = grid.length
y = grid[0].length


pow_grid = Array.new(x) { Array.new(y, 0) }

(0...x).each do |i|
  (0...y).each do |j|
    next unless grid[i][j] == '@'

    (i - 1..i + 1).each do |ii|
      (j - 1..j + 1).each do |jj|
        next if ii == i && jj == j
        next unless ii.between?(0, x - 1) && jj.between?(0, y - 1)

        pow_grid[ii][jj] += 1
      end
    end
  end
end

accessable_rolls_count = 0

(0...x).each do |i|
  (0...y).each do |j|
    next unless grid[i][j] == '@' && pow_grid[i][j] < 4

    accessable_rolls_count += 1
    grid[i][j] = 'x'
  end
end

puts "accessable_rolls_count=#{accessable_rolls_count}"
