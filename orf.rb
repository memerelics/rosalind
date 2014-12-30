require './rosalind'

# Open Reading Frames
# http://rosalind.info/problems/orf/

input = <<-EOF
>Rosalind_99
AGCCATGTAGCTAACTCAGGTTACATGGGGATGACCCCGCGACTTGGATTAGAGTCTCTTTTGGAATAAGCCTGAATGATCCGAGTAGCATCTCAG
EOF

# dna = Fasta.load(input).first.string
dna = Fasta.load(data).first.string

results = []

[dna, DNA.complement(dna).reverse].each do |strand|
  0.upto(2) do |orf|
    protein = strand.chars.drop(orf).join.scan(/.{3}/).map{|str| DNA::TABLE[str.to_sym] }
    indexes = protein.map.with_index{|c, i| c == :M ? i : nil }.compact
    cand = indexes.map do |i|
      if protein[i..-1].include?(:Stop)
        protein[i..-1].take_while{|c| c != :Stop }.join
      else
        nil
      end
    end.compact
    results += cand
  end
end

puts results.uniq.join("\n")
