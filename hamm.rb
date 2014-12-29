# Counting Point Mutations
# http://rosalind.info/problems/hamm/

# input = <<-EOF
# GAGCCTACTAACGGGAT
# CATCGTAATGACGGCCT
# EOF

input = open("/Users/hash/Downloads/rosalind_hamm.txt").read

print input.lines.first.chars.map.with_index{|f, index| f != input.lines.last.chars[index] }.select{|b| b}.count
