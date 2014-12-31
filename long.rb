require './rosalind'

# Genome Assembly as Shortest Superstring
# http://rosalind.info/problems/long/

input = <<-EOF
>Rosalind_56
ATTAGACCTG
>Rosalind_57
CCTGCCGGAA
>Rosalind_58
AGACCTGCCG
>Rosalind_59
GCCGGAATAC
EOF

input = data
records = Fasta.load(input)

class Edge < Struct.new(:overlap, :from, :to)
  # 本問題においては
  # "gluing together pairs of reads that overlap by more than half their length."
  # と刈り込み条件が明確なので, 以下のように使う辺を決める.
  def accepted?
    overlap.length > ([from.string.length, to.string.length].min / 2)
  end

  def head
    from.string[0..-(overlap.length + 1)]
  end

  def tail
    to.string[(overlap.length)..-1]
  end

  def dump
     head + overlap + tail
  end
end

whole_edges = []
records.each.with_index do |record, current|
  records[(current+1)..-1].each do |other|
    from_overlap = overlap(from: record.string, to: other.string)
    to_overlap   = overlap(from:  other.string, to: record.string)
    whole_edges << Edge.new(from_overlap, record,  other) if from_overlap
    whole_edges << Edge.new(to_overlap,    other, record) if to_overlap
  end
end

edges = whole_edges.select{|edge| edge.accepted? }

# # Graphviz確認用有向グラフ出力
# ![](https://github.com/memerelics/rosalind/blob/master/img/long_graphviz.png)
# puts "digraph assem {"
# # edges.each do |edge|
# whole_edges.reject{|edge| edge.overlap.nil? }.each do |edge|
#   puts "  #{edge.from.string} -> #{edge.to.string} [label = \"#{edge.overlap.length}\"];"
# end
# puts "}"

# topological sortで接続順にソート
require 'tsort'

class Edges
  include TSort
  def initialize(ary)
    @ary = ary
  end

  def tsort_each_node(&block)
    @ary.each(&block)
  end
  def tsort_each_child(node, &block)
    if child = @ary.find{|item| item.to.label == node.from.label}
      [child].each(&block)
    else
      [].each(&block)
    end
  end
end

result = ''
sorted_edges = Edges.new(edges).tsort
sorted_edges.each.with_index do |e, i|
  result << e.head
  if i == sorted_edges.length - 1
    result << e.overlap
    result << e.tail
  end
end

# puts "ATTAGACCTGCCGGAATAC (answer of sample input)"
puts result
