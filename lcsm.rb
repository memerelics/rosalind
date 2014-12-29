require './rosalind'

# Finding a Shared Motif
# http://rosalind.info/problems/lcsm/

input = <<-EOF
>Rosalind_1
GATTACA
>Rosalind_2
TAGACCA
>Rosalind_3
ATACA
EOF

def cut(str, n)
  (0..(str.length - n)).map do |i|
    str[i, n]
  end
end
# p cut("ABCDE", 3) #=> ["ABC", "BCD", "CDE"]

# records = Fasta.load(input)
records = Fasta.load(data)

def lcsm(records)
  base = records.first
  (base.string.length).downto(2) do |length|
    cut(base.string, length).each do |pin|
      if records.drop(1).map(&:string).all?{|str| str.index(pin) }
        return pin
      end
    end
  end
end

puts lcsm(records)
