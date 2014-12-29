# Calculating Expected Offspring
# http://rosalind.info/problems/iev/

# input = "1 0 0 1 0 1"


input = open("/Users/hash/Downloads/rosalind_iev.txt").read
integers = input.split.map(&:to_i)

def e(integers)
  integers[0] * 2 * 1.0 +
    integers[1] * 2 * 1.0 +
    integers[2] * 2 * 1.0 +
    integers[3] * 2 * 0.75 +
    integers[4] * 2 * 0.5 +
    integers[5] * 2 * 0
end

p e(integers)
