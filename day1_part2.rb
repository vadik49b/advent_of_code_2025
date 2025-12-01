password = 0
dial = 50

clicks = (0..99).to_a

File.foreach('day1_input.txt') do |line|
  direction = line[0] == 'L' ? -1 : 1
  distance = line[1..].to_i

  distance.times do
    dial = (dial + direction) % 100
    password += 1 if clicks[dial].zero?
  end
end

puts "Password: #{password}"
