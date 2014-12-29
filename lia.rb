# Independent Alleles
# http://rosalind.info/problems/lia/

input = "2 1" # here result should be 0.684
# input = open("/Users/hash/Downloads/rosalind_lia.txt").read

k = input.chomp.split[0]
n = input.chomp.split[1]

# Return: The probability that at least N Aa Bb organisms will belong to the k-th generation of Tom's family tree (don't count the Aa Bb mates at each level).
# Assume that Mendel's second law holds for the factors.

# Mendel's Law:
#   Law of Segregation (the "First Law")
#   Law of Independent Assortment (the "Second Law")
#   Law of Dominance (the "Third Law")

def patterns(pat, mom)
  res = []
  pat.chars.each do |p|
    mom.chars.each do |m|
      res << p + m
    end
  end
  res.map{|item| item.chars.sort.join }
end

# p patterns("Aa", "AA") #=> ["AA", "AA", "Aa", "Aa"]
# p patterns("aa", "AA") #=> ["Aa", "Aa", "Aa", "Aa"]

def reproduce(genotype_p, genotype_m)
  patterns(genotype_p[0..1], genotype_m[0..1])
    .product(patterns(genotype_p[2..3], genotype_m[2..3])).map(&:join)
end

# gen 1: AaBb x AaBb
# p reproduce('AaBb', 'AaBb')
#=> ["AABB", "AABb", "AABb", "AAbb", "AaBB", "AaBb", "AaBb", "Aabb", "AaBB", "AaBb", "AaBb", "Aabb", "aaBB", "aaBb", "aaBb", "aabb"]

def offsprings(generation, accum)
  return accum if generation.zero?
  # Each organism always mates with an organism having genotype Aa Bb.
  # offsprings(generation - 1, accum.reduce(Array.new) {|res, c|
  #   res += reproduce(c, 'AaBb')
  # })

  accum = accum.reduce({}) do |h, (org, prob)|
    children = reproduce(org, 'AaBb')
    org_counts = children.group_by{|x| x }.map{|k, v| [k, v.count] }.to_h
    org_counts.each do |k, count|
      if accum[k]
        h[k] = prob * (count / children.count.to_f)
      else
        h[k] = (count / children.count.to_f)
      end
    end
    h
  end
  offsprings(generation - 1, accum)
end

def init_keys
  {
    "AABB" => 0, "AABb" => 0,
    "AAbb" => 0, "AaBB" => 0,
    "AaBb" => 0,
    "Aabb" => 0, "aaBB" => 0,
    "aaBb" => 0, "aabb" => 0
  }
end

p offsprings(2, {'AaBb' => 1.0}).reduce(0){|sum, (k,v)|
  k != 'AaBb' ? sum = sum + v : sum
} # => 0.125 違う...


# keys = init_keys
# offsprings(2, ['AaBb']).each do |off|
#   keys[off] = keys[off] + 1
# end
#
# p keys
