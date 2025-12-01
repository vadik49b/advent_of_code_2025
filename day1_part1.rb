password = 0
dial = 50

File.foreach('day1_input.txt') do |line|
  direction = line[0] == 'L' ? -1 : 1
  distance = line[1..].to_i

  dial = (dial + direction * distance) % 100

  password += 1 if dial.zero?
end

puts "Password: #{password}"
