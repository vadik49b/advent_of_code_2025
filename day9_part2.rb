require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rgeo', '~> 3.0.1'
end

puts "Inline dependencies installed"

coordinates =
  File
  .readlines('day9_input.txt', chomp: true)
  .map { |l| l.split(',').map(&:to_i) }

factory = RGeo::Cartesian.factory
polygon =
  factory.polygon(
    factory.linear_ring(coordinates.map { |c| factory.point(c[0], c[1]) })
  )

areas = []

(0...coordinates.length).each do |i|
  (i + 1...coordinates.length).each do |j|
    xi, yi = coordinates[i]
    xj, yj = coordinates[j]
    area = ((xi - xj).abs + 1) * ((yi - yj).abs + 1)

    square =
      factory.polygon(
        factory.linear_ring(
          [
            factory.point([xi, xj].min, [yi, yj].min),
            factory.point([xi, xj].min, [yi, yj].max),
            factory.point([xi, xj].max, [yi, yj].max),
            factory.point([xi, xj].max, [yi, yj].min)
          ]
        )
      )

    areas << [area, i, j] if square.valid? && square.within?(polygon)
  end
end

areas.sort!

puts "largest_area=#{areas.last[0]}"
