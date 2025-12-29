input = File.readlines('day11_input.txt', chomp: true)

$racks = input.map do |l|
  from, to_arr = l.split(': ')

  [from, to_arr.split]
end.to_h

def paths_between(a, b, memo = {})
  return memo[[a, b]] if memo.key?([a, b])

  return 1 if a == b

  result = $racks.fetch(a, []).map { |o| paths_between(o, b, memo) }.sum
  memo[[a, b]] = result
end


puts "paths_count(svr->fft->dac->out)=#{paths_between('svr', 'fft') * paths_between('fft', 'dac') * paths_between('dac', 'out')}"
