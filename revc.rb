def comp(s)
  case s
  when 'A' then 'T'
  when 'T' then 'A'
  when 'C' then 'G'
  when 'G' then 'C'
  end
end

open("/Users/hash/Downloads/rosalind_revc.txt").read.strip.chars.map{|s| comp(s) }.reverse.join
