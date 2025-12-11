diagram = File.readlines('day7_input.txt', chomp: true).map { |l| l.split('') }

beam_splits_count = 0
beams = Set[diagram.first.index('S')]
(1...diagram.length).each do |i|
  next_beams = Set[]

  beams.each do |bi|
    if diagram[i][bi] == '.'
      next_beams << bi
    elsif diagram[i][bi] == '^'
      next_beams << bi - 1
      next_beams << bi + 1
      beam_splits_count += 1
    end
  end

  beams = next_beams
end

puts "beam_splits_count=#{beam_splits_count}"
