require './rosalind'

# Inferring mRNA from Protein
# http://rosalind.info/problems/mrna/

MOD = 1_000_000

def possible_rnas(str)
  t = RNA::TABLE.group_by{|k, v| v }.map{|key, v| [key, v.count] }.to_h
  str.chars.reduce(1){|acc, c|
    # acc = (acc / MOD).round if acc > MOD
    acc * t[c.to_sym]
  } * t[:Stop]
end
# p possible_rnas("MA") % MOD # => 12

p possible_rnas(data) % MOD
