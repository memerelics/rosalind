# Finding a Motif in DNA
# http://rosalind.info/problems/subs/

# hay = 'GATATATGCATATACTT'
# pin = 'ATAT'

input = open("/Users/hash/Downloads/rosalind_subs.txt").read.chomp

puts hay = input.lines[0]
puts pin = input.lines[1]

res = []
loop do
  if found = hay.index(pin, res.last ? res.last + 1 : 0)
    res << found
  else
    break
  end
end

print res.map{|i| i + 1 }.join(' ')
