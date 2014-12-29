# Translating RNA into Protein
# http://rosalind.info/problems/prot/

table = {
  UUU: :F,    CUU: :L, AUU: :I, GUU: :V,
  UUC: :F,    CUC: :L, AUC: :I, GUC: :V,
  UUA: :L,    CUA: :L, AUA: :I, GUA: :V,
  UUG: :L,    CUG: :L, AUG: :M, GUG: :V,
  UCU: :S,    CCU: :P, ACU: :T, GCU: :A,
  UCC: :S,    CCC: :P, ACC: :T, GCC: :A,
  UCA: :S,    CCA: :P, ACA: :T, GCA: :A,
  UCG: :S,    CCG: :P, ACG: :T, GCG: :A,
  UAU: :Y,    CAU: :H, AAU: :N, GAU: :D,
  UAC: :Y,    CAC: :H, AAC: :N, GAC: :D,
  UAA: :Stop, CAA: :Q, AAA: :K, GAA: :E,
  UAG: :Stop, CAG: :Q, AAG: :K, GAG: :E,
  UGU: :C,    CGU: :R, AGU: :S, GGU: :G,
  UGC: :C,    CGC: :R, AGC: :S, GGC: :G,
  UGA: :Stop, CGA: :R, AGA: :R, GGA: :G,
  UGG: :W,    CGG: :R, AGG: :R, GGG: :G,
}


# input = "AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA"
input = open("/Users/hash/Downloads/rosalind_prot.txt").read

result = ''
input.scan(/.{3}/).map{|codon| table[codon.to_sym] }.each do |prot|
  break if prot == :Stop
  result << prot.to_s
end

print result
