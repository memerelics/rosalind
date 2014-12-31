require './rosalind'
require 'set'

# Introduction to Set Operations
# http://rosalind.info/problems/seto/

input = <<-EOF
10
{1, 2, 3, 4, 5}
{2, 8, 5, 10}
EOF

input = data

n = input.lines[0].chomp.to_i
setA = Set[*input.lines[1].chomp.gsub(/[{,}]/, '').split.map(&:to_i)]
setB = Set[*input.lines[2].chomp.gsub(/[{,}]/, '').split.map(&:to_i)]

union = Set[*(1..n)]

puts "{#{(setA | setB).to_a.join(', ')}}"
puts "{#{(setA & setB).to_a.join(', ')}}"
puts "{#{(setA - setB).to_a.join(', ')}}"
puts "{#{(setB - setA).to_a.join(', ')}}"
puts "{#{(union - setA).to_a.join(', ')}}"
puts "{#{(union - setB).to_a.join(', ')}}"
