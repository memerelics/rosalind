require './rosalind'
require 'bigdecimal'

# Introduction to Random Strings
# http://rosalind.info/problems/prob/

input = <<-EOF
ACGATACAA
0.129 0.287 0.423 0.476 0.641 0.742 0.783
EOF

input = data

s = input.lines[0].chomp
gcs = input.lines[1].chomp.split.map(&:to_f)

def rate(c, gcrate)
  bgcr = BigDecimal::new(gcrate.to_s)
  case c
  when 'G', 'C' then bgcr / BigDecimal::new('2')
  when 'A', 'T' then (BigDecimal::new('1') - bgcr) / BigDecimal::new('2')
  end
end


puts gcs.map {|gcrate|
  "%.3f" % Math.log10(s.chars.map{|c| rate(c, gcrate) }.reduce(&:*)).round(3)
}.map(&:to_s).join(' ')

