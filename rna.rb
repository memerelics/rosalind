# DNA -> RNA
# http://rosalind.info/problems/rna/

def a(n)
  n == 'T' ? 'U' : n
end

open("/Users/hash/Downloads/rosalind_rna.txt").read.strip.chars.map{|n| a(n) }.join
