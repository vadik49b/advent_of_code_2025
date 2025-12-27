require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'z3', '~> 0.0.20251017'
end

puts 'Inline dependencies installed'

input = File.readlines('day10_input.txt', chomp: true).map(&:split)

#        |0  |1    |2  |3    |4    |5
# [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
# x -- buttons
# f(x0, .., x5) = c0*x0 + ... + c5*x5
# a04*x4 + a05*x5 = 3
# a11*x1 + a15*x5 = 5
# ...
def optimal_button_presses(start, goal, buttons)
  opt = Z3::Optimize.new

  x = Array.new(buttons.length) { |i| Z3.Int("x#{i}") }

  buttons.length.times { |i| opt.assert(x[i] >= 0) }

  goal.each_with_index do |digit, i|
    digit_constraint = buttons.each_with_index
                              .select { |b, _j| b.include?(i) }
                              .map { |_b, j| x[j] }
                              .reduce(:+)

    opt.assert(digit_constraint == digit)
  end

  opt.minimize(x.reduce(:+))

  opt.model.to_h.values.reduce(:+).to_i if opt.satisfiable?
end

optimal_button_presses_count = input.map do |manual_line|
  target_joltage = manual_line[-1].delete('{}').split(',').map(&:to_i)
  buttons = manual_line[1..-2].map { |b| b.delete('()').split(',').map(&:to_i) }

  puts "Calculating #{target_joltage}"

  optimal_button_presses(Array.new(target_joltage.length, 0), target_joltage, buttons)
end

puts "fewes_button_presses_sum=#{optimal_button_presses_count.sum}"
