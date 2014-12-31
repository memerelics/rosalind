require './rosalind'

input = data # '6 3'
n = input.chomp.split[0].to_i
m = input.chomp.split[1].to_i

puts (m..n).reduce(0) {|sum, k|
 # print "k = #{k} : "
 # puts "#{((n - k + 1)..n).to_a} / #{(1..k).to_a}"
 sum += (((n - k + 1)..n).reduce(&:*) / (1..k).reduce(&:*))
} % 1_000_000
