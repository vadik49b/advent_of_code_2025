input = File.readlines('day11_input.txt', chomp: true)

racks = input.map do |l|
  from, to_arr = l.split(': ')

  [from, to_arr.split]
end.to_h

queue = [['you', racks['you'], ['you']]]

path_out_count = 0

until queue.empty?
  current, to_arr, path = queue.pop

  if current == 'out'
    path_out_count += 1
  else
    to_arr.each do |to|
      queue << [to, racks[to], path + [to]]
    end
  end
end

puts "path_out_count=#{path_out_count}"
