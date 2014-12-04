# 塩基カウント
# http://rosalind.info/problems/dna/

def a(ary, c)
  case c
  when 'A' then ary[0] = ary[0] + 1
  when 'C' then ary[1] = ary[1] + 1
  when 'G' then ary[2] = ary[2] + 1
  when 'T' then ary[3] = ary[3] + 1
  end
  ary
end

open("/Users/hash/Downloads/rosalind_dna.txt").read.strip.chars.reduce([0,0,0,0]){|res,c| a(res, c) }

