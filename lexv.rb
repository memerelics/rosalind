require './rosalind'

input = <<-EOF
D N A
3
EOF

input = data

chars = input.lines[0].chomp.split
n = input.lines[1].chomp.to_i

def a(chars, count)
  return chars if count == 1
  chars.product(a(chars, count - 1))
end

wei = (1..n).map {|i|
  a(chars, i).map{|set| set.is_a?(Array) ? set.flatten.join : set }
}.flatten

# 普通にsortすると辞書順になるので与えられたcharsの出現順になるようsort
puts wei.sort_by{|str| str.chars.map{|c| chars.index(c) }}.join("\n")
