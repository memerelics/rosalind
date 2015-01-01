require './rosalind'

# Transitions and Transversions
# http://rosalind.info/problems/tran/

input = <<-EOF
>Rosalind_0209
GCAACGCACAACGAAAACCCTTAGGGACTGGATTATTTCGTGATCGTTGTAGTTATTGGA
AGTACGGGCATCAACCCAGTT
>Rosalind_2200
TTATCTGACAAAGAAAGCCGTCAACGGCTGGATAATTTCGCGATCGTGCTGGTTACTGGC
GGTACGAGTGTTCCTTTGGGT
EOF

records = Fasta.load(data)
one = records[0].string
two = records[1].string

# prine同士, pyrimidine同士の変異は起こりやすい
def transition?(a, b)
  return false if a == b
  [a, b] == ['A', 'G'] ||
    [a, b] == ['G', 'A'] ||
    [a, b] == ['C', 'T'] ||
    [a, b] == ['T', 'C']
end

# それ以外はtransversion.
def transversion?(a, b)
  return false if a == b
  !transition?(a, b)
end

transitions = transversions = 0
(0..(one.length - 1)).each do |i|
  transitions += 1 if transition?(one[i], two[i])
  transversions += 1 if transversion?(one[i], two[i])
end

p transitions.to_f / transversions
