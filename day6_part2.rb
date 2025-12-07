input = File.readlines('day6_input.txt', chomp: true)

operations = input.last.split
problem = ''
k = 0

(0...input[0].length).each do |j|
  num = (0...input.length - 1).sum('') do |i|
    input[i][j]
  end

  if num.strip.empty?
    problem = "#{problem.chop}+"
    k += 1
  else
    problem = "#{problem}#{num.strip}#{operations[k]}"
  end
end

puts "#{problem.chop}=#{eval(problem.chop)}"
