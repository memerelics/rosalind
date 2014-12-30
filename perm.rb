input = 5

perm = (1..input).to_a.permutation(input)
puts perm.count
perm.map {|order| puts order.join(' ') }
