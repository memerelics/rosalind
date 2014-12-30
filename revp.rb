require './rosalind'

# Locating Restriction Sites
# http://rosalind.info/problems/revp/

## reverse palindrome sample
# sample = 'GCATGC'
# p sample == DNA.complement(sample).reverse #=> true

def palindrome?(str)
  str == DNA.complement(str).reverse
end

input = <<-EOF
>Rosalind_24
TCAATGCATGCGGGTCTATATGCAT
EOF

def frames(str, n)
  res = []
  (0..(str.length - 1)).each do |i|
    rest = str.chars.drop(i)
    break if rest.length < n
    res << rest[0..(n - 1)].join
  end
  res
end
# p frames('TCAATGCATGCGGGTCTATATGCAT', 4)
# #=> ["TCAA", "CAAT", "AATG", "ATGC", "TGCA", "GCAT", "CATG", "ATGC",
#      "TGCG", "GCGG", "CGGG", "GGGT", "GGTC", "GTCT", "TCTA", "CTAT",
#      "TATA", "ATAT", "TATG", "ATGC", "TGCA", "GCAT"]

# dna = Fasta.load(input)[0].string
dna = Fasta.load(data)[0].string
results = []
(4..12).each do |length|
  frames(dna, length).each.with_index do |subst, frame_index|
    # ホントはindex保持したほうが無駄がないけど再度さがしてる
    if palindrome?(subst)
      results << [dna.index(subst, frame_index) + 1, length]
    end
  end
end

puts results.sort.map{|chars| chars.join(' ') }
