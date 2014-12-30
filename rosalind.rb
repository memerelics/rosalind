def data(dir='/Users/hash/Downloads')
  base = File.basename(caller.first.split(':').first, '.rb')
  datafile = "#{dir}/rosalind_#{base}.txt"
  return nil unless File.exist?(datafile)
  open(datafile).read.chomp
end

module RNA
  TABLE = {
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
end

module DNA
  TABLE = RNA::TABLE.map{|k,v| [k.to_s.gsub('U', 'T').to_sym, v] }.to_h

  def self.complement(strand)
    strand.chars.map{|c| pair(c) }.join
  end

  def self.pair(c)
    case c
    when 'A' then 'T'
    when 'T' then 'A'
    when 'C' then 'G'
    when 'G' then 'C'
    end
  end
end

module Fasta

  def self.load(data, label_expander=nil)
    records = []
    data.lines.each do |line|
      if line =~ /^>/
        label = if label_expander
                  label_expander.call(line.chomp.gsub('>', ''))
                else
                  line.chomp.gsub('>', '')
                end
        records << Record.new(label, '')
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

  describe :DNA do
    let(:strand) { 'AGCCATG' }
    it '.complement' do
      DNA.complement(strand).must_equal 'TCGGTAC'
    end
  end

  describe :Fasta do
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
end
