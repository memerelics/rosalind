require './rosalind'

# Enumerating k-mers Lexicographically
# http://rosalind.info/problems/lexf/

input = <<-EOF
T A G C
2
EOF

input = data
symbols = input.lines[0].chomp.split
n = input.lines[1].chomp.to_i

puts symbols.repeated_permutation(n).to_a.map(&:join).join("\n")
