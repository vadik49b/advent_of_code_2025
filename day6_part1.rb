input = File.readlines('day6_input.txt', chomp: true).map(&:split)

grand_total = (0...input[0].length).sum do |j|
  if input.last[j] == '+'
    (0...input.length - 1).inject(0) { |r, i| r + input[i][j].to_i }
  else
    (0...input.length - 1).inject(1) { |r, i| r * input[i][j].to_i }
  end
end

puts "grand_total=#{grand_total}"
