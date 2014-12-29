# Computing GC Content
# http://rosalind.info/problems/gc/

def gc(str)
  count = str.chars.reduce(0){|sum, c| ['C', 'G'].include?(c) ? sum = sum + 1 : sum  }
  ( 100*(count.to_f) / str.length ).round(6)
end

# puts gc("AGCTATAG")
# puts gc("CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCCTCCCACTAATAATTCTGAGG")
# puts gc("CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCTATATCCATTTGTCAGCAGACACGC")
# puts gc("CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT")

class Record < Struct.new(:label, :string, :gc_ratio)
end

# input = <<-EOF
# >Rosalind_6404
# CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
# TCCCACTAATAATTCTGAGG
# >Rosalind_5959
# CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
# ATATCCATTTGTCAGCAGACACGC
# >Rosalind_0808
# CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
# TGGGAACCTGCGGGCAGTAGGTGGAAT
# EOF

input = open("/Users/hash/Downloads/rosalind_gc.txt").read

records = []
input.lines.each do |line|
  if line =~ /^>Rosalind_/
    records << Record.new(line.chomp.gsub('>', ''), '')
  else
    records.last.string += line.chomp
  end
end

records.each do |record|
  record.gc_ratio = gc(record.string)
end

# puts records

max = records.sort_by{|r| -r.gc_ratio }.first
puts max.label
print ("%.06f" % max.gc_ratio)
