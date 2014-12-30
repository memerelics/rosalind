require './rosalind'

# RNA Splicing
# http://rosalind.info/problems/splc/

input = <<-EOF
>Rosalind_10
ATGGTCTACATAGCTGACAAACAGCACGTAGCAATCGGTCGAATCTCGAGAGGCATATGGTCACATGATCGGTCGAGCGTGTTTCAAAGTTTGCGCCTAG
>Rosalind_12
ATCGGTCGAA
>Rosalind_15
ATCGGTCGAGCGTGT
EOF

# records = Fasta.load(input)
records = Fasta.load(data)

dna = records.first.string
introns = records.drop(1).map(&:string)

#p dna, dna.length
#p introns, introns.map(&:length)

introns.each do |intron|
  dna = dna.gsub(intron, '')
end

# p dna, dna.length

base = dna.scan(/.{3}/).map{|codon| DNA::TABLE[codon.to_sym] }
puts base[base.index(:M)..-1].take_while{|c| c != :Stop }.join
