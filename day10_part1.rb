input = File.readlines('day10_input.txt', chomp: true).map(&:split)

def bfs(start, goal, buttons)
  queue = [[start, []]]
  visited = Set.new([start])

  while queue.any?
    state, path = queue.shift
    return path if state == goal

    next_states(state, buttons).each do |next_state, button|
      next if visited.include?(next_state)

      visited.add(next_state)
      queue.push([next_state, path + [button]])
    end
  end

  nil
end

def next_states(state, buttons)
  buttons.map do |button|
    next_state = state.dup
    button.each { |i| next_state[i] = !next_state[i] }

    [next_state, button]
  end
end

configurations = input.map do |manual_line|
  goal = manual_line[0].delete('[]').chars.map { |i| i == '#' }
  buttons = manual_line[1..-2].map { |b| b.delete('()').split(',').map(&:to_i) }

  bfs(Array.new(goal.length, false), goal, buttons)
end

puts "fewes_button_presses_sum=#{configurations.map(&:length).sum}"
