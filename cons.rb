require './rosalind'

# Consensus and Profile
# http://rosalind.info/problems/cons/

input = <<-EOF
>Rosalind_1
ATCCAGCT
>Rosalind_2
GGGCAACT
>Rosalind_3
ATGGATCT
>Rosalind_4
AAGCAACC
>Rosalind_5
TTGGAACT
>Rosalind_6
ATGCCATT
>Rosalind_7
ATGGCACT
EOF


# records = Fasta.load(input)
records = Fasta.load(data)

def profile(dnas)
  # assume that all dna length are same
  n = dnas.first.length
  res = {
    A: Array.new(n, 0),
    C: Array.new(n, 0),
    G: Array.new(n, 0),
    T: Array.new(n, 0)
  }
  dnas.each do |dna|
    dna.chars.each.with_index do |c, i|
      res[c.to_sym][i] += 1
    end
  end
  res
end

def consensus(prof)
  n = prof.values.first.length
  (0..(n - 1)).map{|i|
    prof.sort_by{|k, v| -v[i] }.first.first
  }.join
end

prof = profile(records.map(&:string))
puts consensus(prof)
[:A, :C, :G, :T].each do |c|
  puts "#{c}: #{prof[c].join(' ')}"
end
