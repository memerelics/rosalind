def data(dir='/Users/hash/Downloads')
  base = File.basename(caller.first.split(':').first, '.rb')
  datafile = "#{dir}/rosalind_#{base}.txt"
  return nil unless File.exist?(datafile)
  open(datafile).read
end


module Fasta

  def self.load(data)
    records = []
    data.lines.each do |line|
      if line =~ /^>/
        records << Record.new(line.chomp.gsub('>', ''), '')
      else
        records.last.string += line.chomp
      end
    end
    records
  end

  class Record < Struct.new(:label, :string)
  end
end

if $0 == __FILE__
  require 'minitest/spec'
  require 'minitest/autorun'

  data = <<-EOF
>Rosalind_6404
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
TCCCACTAATAATTCTGAGG
>Rosalind_5959
CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
ATATCCATTTGTCAGCAGACACGC
>Rosalind_0808
CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
TGGGAACCTGCGGGCAGTAGGTGGAAT
EOF

  describe '.load' do
    let(:res) { Fasta.load(data) }
    it 'separate' do
      res.count.must_equal 3
    end
    it 'join' do
      res.last.string.length.must_equal 87
    end
  end
end
