# Mendel's First Law
# http://rosalind.info/problems/iprb/

def build_set(ai, bi, ci)
  result = []
  result = result + (1..ai).map{|i| "A|#{i}" } # YY
  result = result + (1..bi).map{|i| "B|#{i}" } # Yy
  result = result + (1..ci).map{|i| "C|#{i}" } # yy
  result
end

def ratio(pair)
  return 1.0  if pair.first.include?('A') && pair.last.include?('A')
  return 1.0  if pair.first.include?('A') && pair.last.include?('B')
  return 1.0  if pair.first.include?('B') && pair.last.include?('A')
  return 0.75 if pair.first.include?('B') && pair.last.include?('B')

  return 1.0  if pair.first.include?('A') && pair.last.include?('C')
  return 1.0  if pair.first.include?('C') && pair.last.include?('A')

  return 0.5  if pair.first.include?('B') && pair.last.include?('C')
  return 0.5  if pair.first.include?('C') && pair.last.include?('B')

  return 0    if pair.first.include?('C') && pair.last.include?('C')
  raise 'wei'
end

# input = "2 2 2"
input = open("/Users/hash/Downloads/rosalind_iprb.txt").read

args = input.chomp.split.map(&:to_i)
set  = build_set(*args)
# print build_set(*args) #=> ["A|1", "A|2", "B|1", "B|2", "C|1", "C|2"]

res = set.combination(2).reduce(0) do |sum, pair|
  sum = sum + ratio(pair)
  sum
end

print res.to_f/set.combination(2).count
