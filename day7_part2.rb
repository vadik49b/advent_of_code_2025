diagram = File.readlines('day7_input.txt', chomp: true).map { |l| l.split('') }

# .......S.......0
# .......1.......1
# ......1^1......2
# ......1.1......3
# .....1^2^1.....4
# .....1.2.1.....5
# ....1^3^3^1....6
# ....1.3.3.1....7
# ...1^4^|||^|...8
# ...|.|.|||.|...9
# ...^.^...^.^...10
# ...............11
# ..^...^.....^..12
# ...............13
# .^.^.^.^.^...^.14
# ...............15

beams = [Set[diagram.first.index('S')]]
(1...diagram.length).each do |i|
  next_beams = Set[]

  beams.last.each do |bi|
    if diagram[i][bi] == '.'
      next_beams << bi
    elsif diagram[i][bi] == '^'
      next_beams << bi - 1
      next_beams << bi + 1
    end
  end

  beams << next_beams
end

(0...diagram.length).each do |i|
  beams[i].each do |bi|
    diagram[i][bi] = '|'
  end
end

diagram[0][beams.first.first] = 1
(1...diagram.length).each do |i|
  diagram[i].each_with_index do |c, j|
    next unless c == '|'

    diagram[i][j] = 0
    diagram[i][j] += diagram[i - 1][j].to_i if diagram[i - 1][j].is_a?(Integer)
    diagram[i][j] += diagram[i - 1][j - 1].to_i if diagram[i][j - 1] == '^'
    diagram[i][j] += diagram[i - 1][j + 1].to_i if diagram[i][j + 1] == '^'
  end
end

puts "different_timelines_count=#{diagram.last.reject { |c| c == '.' }.sum}"
