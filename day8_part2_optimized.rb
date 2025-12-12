boxes = File.readlines('day8_input.txt', chomp: true).map { |l| l.split(',').map(&:to_i) }
N = boxes.length

# Build adjacency list of edges instead of full matrix
edges = []
(0...N).each do |i|
  (i+1...N).each do |j|
    xi, yi, zi = boxes[i]
    xj, yj, zj = boxes[j]
    d = Math.sqrt((xi - xj)**2 + (yi - yj)**2 + (zi - zj)**2)
    edges << [d, i, j]
  end
end

# Sort edges by distance once
edges.sort!

# Union-Find data structure for efficient cycle detection
parent = (0...N).to_a
rank = Array.new(N, 0)

def find(parent, x)
  parent[x] = find(parent, parent[x]) if parent[x] != x
  parent[x]
end

def union(parent, rank, x, y)
  px, py = find(parent, x), find(parent, y)
  return false if px == py

  if rank[px] < rank[py]
    parent[px] = py
  elsif rank[px] > rank[py]
    parent[py] = px
  else
    parent[py] = px
    rank[px] += 1
  end
  true
end

# Kruskal's algorithm
connections = []
edges.each do |dist, i, j|
  if union(parent, rank, i, j)
    puts "connecting #{boxes[i]} and #{boxes[j]}, dist=#{dist}"
    connections << [boxes[i], boxes[j]]
    break if connections.length == N - 1
  end
end

b0, b1 = connections.last
puts "x0 * x1 = #{b0[0] * b1[0]}"
