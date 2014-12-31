require './rosalind'

n = data.chomp.to_i
puts fact(n) * (2 ** n)

bins = (2**n - 1).downto(0).map {|i|
  "%0#{n}b" % i
  # => ["111", "110", "101", "100", "011", "010", "001", "000"]
}.map {|bin|
  bin.chars.map.with_index {|c, i|
    c.to_i.zero? ? -1 : 1
  }
}
# => [[1, 1, 1], [1, 1, -1], [1, -1, 1], [1, -1, -1],
#     [-1, 1, 1], [-1, 1, -1], [-1, -1, 1], [-1, -1, -1]]

(1..n).to_a.permutation.to_a.each do |pat|
  bins.each do |bin|
  puts pat.zip(bin).map{|pair| pair.reduce(&:*) }.join(' ')
  end
end
