require './rosalind'

# k-Mer Composition
# http://rosalind.info/problems/kmer/

# http://rosalind.info/glossary/k-mer-composition/

input = <<-EOF
>Rosalind_6431
CTTCGAAAGTTTGGGCCGAGTCTTACAGTCGGTCTTGAAGCAAAGTAACGAACTCCACGG
CCCTGACTACCGAACCAGTTGTGAGTACTCAACTGGGTGAGAGTGCAGTCCCTATTGAGT
TTCCGAGACTCACCGGGATTTTCGATCCAGCCTCAGTCCAGTCTTGTGGCCAACTCACCA
AATGACGTTGGAATATCCCTGTCTAGCTCACGCAGTACTTAGTAAGAGGTCGCTGCAGCG
GGGCAAGGAGATCGGAAAATGTGCTCTATATGCGACTAAAGCTCCTAACTTACACGTAGA
CTTGCCCGTGTTAAAAACTCGGCTCACATGCTGTCTGCGGCTGGCTGTATACAGTATCTA
CCTAATACCCTTCAGTTCGCCGCACAAAAGCTGGGAGTTACCGCGGAAATCACAG
EOF

# dna = Fasta.load(input)[0].string
dna = Fasta.load(data)[0].string

_4mers = %w(A T G C).repeated_permutation(4).map(&:join).sort
hash = _4mers.map{|mer| [mer, 0] }.to_h

# 最初に全4-mer作るやり方はデータが大きいと間に合わない
# k_mer(dna, 4).each do |str|
#   hash[str] += 1
# end

# なので対象フレームをFIFOキューでずらしつつカウント
q = []
dna.chars.each do |c|
  q << c
  q.shift if q.size > 4
  next if q.size < 4
  hash[q.join] += 1
end

puts hash.values.join(' ')
