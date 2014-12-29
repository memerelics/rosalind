require './rosalind'

# Overlap Graphs
# http://rosalind.info/problems/grph/


input = <<-EOF
>Rosalind_0498
AAATAAA
>Rosalind_2391
AAATTTT
>Rosalind_2323
TTTTCCC
>Rosalind_0442
AAATCCC
>Rosalind_5013
GGGTGGG
EOF

# def cut(str, n)
#   (0..(str.length - n)).map do |i|
#     str[i, n]
#   end
# end
# # p cut("ABCDE", 3) #=> ["ABC", "BCD", "CDE"]

# records = Fasta.load(input)
records = Fasta.load(data)

records.combination(2).each do |record, other|
  next if record.label == other.label
  next if record.string == other.string
  next if record.string == other.string.reverse

  if other.string[0..2] == record.string[-3..-1]
    # print "match: #{other.string[0..2]}, #{record.string[-3..-1]} : "
    puts "#{record.label} #{other.label}"
    # puts "#{record.label}(#{record.string}) #{other.label}(#{other.string})"
  elsif record.string[0..2] == other.string[-3..-1]
    # print "match: #{record.string[0..2]}, #{other.string[-3..-1]} : "
    puts "#{other.label} #{record.label}"
    # puts "#{other.label}(#{other.string}) #{record.label}(#{record.string})"
  end
end
