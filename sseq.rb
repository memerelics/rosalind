require './rosalind'

# Finding a Spliced Motif
# http://rosalind.info/problems/sseq/

input = <<-EOF
>Rosalind_14
ACGTACGTGACG
>Rosalind_18
GTA
EOF

records = Fasta.load(data)
dna = records[0].string
pin = records[1].string

indices = []
pin.chars.each do |c|
  indices << dna.index(c, (indices.last ? indices.last + 1 : 0)) + 1
end
puts indices.join(' ')
